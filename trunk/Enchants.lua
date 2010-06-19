--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
----------------------------------------------------------------------]]

local PhanxTempEnchantFrame = CreateFrame("Frame", "PhanxTempEnchantFrame", UIParent)

local db

local enchants = { }
local dirty, bagsDirty, spellsDirty, inVehicle

local MAIN_HAND_SLOT = GetInventorySlotInfo("MainHandSlot")
local OFF_HAND_SLOT = GetInventorySlotInfo("SecondaryHandSlot")

local _, ns = ...
local GetFontFile = ns.GetFontFile
local L = ns.L

------------------------------------------------------------------------

local function button_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
	local remaining
	if self.arg1 and self.arg2 then
		if bagsDirty then
			PhanxTempEnchantFrame:UpdateTempEnchants()
			bagsDirty = nil
		end
		GameTooltip:SetBagItem(self.arg1, self.arg2)
		remaining = self.expires - GetTime()
	elseif self.arg1 then
		if spellsDirty then
			PhanxTempEnchantFrame:UpdateTempEnchants()
			spellsDirty = nil
		end
		GameTooltip:SetSpell(self.arg1, BOOKTYPE_SPELL)
		remaining = self.expires - GetTime()
	else
		GameTooltip:SetInventoryItem("player", self:GetID())
	end
	if remaining then
		if remaining > 59 then
			GameTooltip:AddLine(math.floor((remaining / 60) + 0.5) .. " minutes remaining")
		else
			GameTooltip:AddLine(math.floor(remaining + 0.5) .. " seconds remaining")
		end
		GameTooltip:Show()
	end
end

local function button_OnLeave()
	GameTooltip:Hide()
end

local function button_OnClick(self)
	if self:GetID() == MAIN_HAND_SLOT then
		CancelItemTempEnchantment(1)
	elseif self:GetID() == OFF_HAND_SLOT then
		CancelItemTempEnchantment(2)
	end
end

local buttons = setmetatable({ }, { __index = function(t, i)
	local f = CreateFrame("Button", nil, PhanxTempEnchantFrame)
	f:SetWidth(db.buffSize)
	f:SetHeight(db.buffSize)
	f:Show()

	if i > 1 then
		f:SetPoint("TOPRIGHT", t[i - 1], "TOPLEFT", -db.buffSpacing, 0)
	else
		f:SetPoint("TOPRIGHT", PhanxTempEnchantFrame, "TOPRIGHT", 0, 0)
	end

	f:EnableMouse(true)
	f:SetScript("OnEnter", button_OnEnter)
	f:SetScript("OnLeave", button_OnLeave)

	f:RegisterForClicks("RightButtonUp")
	f:SetScript("OnClick", button_OnClick)

	f.icon = f:CreateTexture(nil, "ARTWORK")
	f.icon:SetAllPoints(f)

	f.count = f:CreateFontString(nil, "OVERLAY")
    f.count:SetPoint("CENTER", f, "TOP")
	f.count:SetFont(GetFontFile(db.fontFace), db.buffSize * 0.6, "OUTLINE")

	f.timer = f:CreateFontString(nil, "OVERLAY")
	f.timer:SetPoint("TOP", f, "BOTTOM")
	f.timer:SetFont(GetFontFile(db.fontFace), db.buffSize * 0.5, "OUTLINE")

	if PhanxBorder then
		PhanxBorder.AddBorder(f)
		f.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
		f:SetBorderColor(180 / 255, 76 / 255, 1) -- 118 / 255, 47 / 255, 170 / 255)
	else
		f.border = f:CreateTexture(nil, "OVERLAY")
		f.border:SetTexture("Interface\\Buttons\\UI-TempEnchant-Border")
		f.border:SetAllPoints(f)
	end

	t[i] = f
	return f
end })

PhanxTempEnchantFrame.buttons = buttons

------------------------------------------------------------------------

local function FindTempEnchantItem(findString)
	findString = findString:gsub("%(.-%)", ""):trim():lower()
	--print("Searching for temp enchant item '" .. findString .. "'")
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local icon, _, _, _, _, _, link = GetContainerItemInfo(bag, slot)
			if link then
				local name = link:match("%[(.+)%]")
				if name:lower():match(findString) then
					--print("Found item: '" .. name .. "'")
					return icon, bag, slot
				end
			end
		end
	end
end

local function FindTempEnchantSpell(findString)
	local findRank = findString:match("%d+")
	findString = findString:gsub("%d+", ""):trim()

	local i = 1
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then break end
		if spellName:find(findString) then
			if findRank then
				if spellRank then
					spellRank = spellRank:match("%d+")
					if spellRank == findRank then
						local _, _, icon = GetSpellInfo(spellName)
						return icon, i
					end
				end
			else
				local _, _, icon = GetSpellInfo(spellName)
				return icon, i
			end
		end
		i = i + 1
	end
end

local tempEnchantKeywords
if select(2, UnitClass("player")) == "SHAMAN" then
	tempEnchantKeywords = {
		[L["Earthliving"]] = GetSpellInfo(51994),
		[L["Flametongue"]] = GetSpellInfo(58790),
		[L["Frostbrand"]]  = GetSpellInfo(58796),
		[L["Windfury"]]    = GetSpellInfo(58804),
	}
elseif select(2, UnitClass("player")) == "ROGUE" then
	tempEnchantKeywords = {
		[L["Anesthetic Poison"]] = true,
		[L["Crippling Poison"]] = true,
		[L["Deadly Poison"]] = true,
		[L["Instant Poison"]] = true,
		[L["Mind-Numbing Poison"]] = true,
		[L["Wound Poison"]] = true,
	}
elseif select(2, UnitClass("player")) == "WARLOCK" then
	tempEnchantKeywords = {
		[L["Firestone"]] = true,
		[L["Spellstone"]] = true,
	}
end

local function FindTempEnchantString()
	for i = 1, PhanxTempEnchantFrame.tooltip:NumLines() do
		local line = PhanxTempEnchantFrame.tooltip.L[i]
		for k, v in pairs(tempEnchantKeywords) do
			if line:find(k) then
				if type(v) == "string" then
					local rank = line:match("( %d+)") or ""
					-- print("Found temp enchant string " .. k .. " (spell " .. v .. ") rank " .. rank)
					return v .. rank, FindTempEnchantSpell
				else
					-- print("Found temp enchant string " .. k .. " (item)")
					return k, FindTempEnchantItem
				end
			end
		end
	end
end

------------------------------------------------------------------------

function PhanxTempEnchantFrame:UpdateTempEnchants()
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()

	local numEnchants = 0

	if hasMainHandEnchant then
		local b = buttons[1]

		b.expires = GetTime() + (mainHandExpiration / 1000)
		b.icon:SetTexture(GetInventoryItemTexture("player", MAIN_HAND_SLOT))

		b.arg1, b.arg2 = nil, nil
		if tempEnchantKeywords and db.showTempEnchantSources then
			self.tooltip:SetInventoryItem("player", MAIN_HAND_SLOT)
			local tempEnchantString, tempEnchantFindFunc = FindTempEnchantString()
			if tempEnchantString then
				local icon, arg1, arg2 = tempEnchantFindFunc(tempEnchantString)
				if icon and icon ~= "" then
					b.icon:SetTexture(icon)
					b.arg1 = arg1
					b.arg2 = arg2
				end
			end
		end

		b.count:SetText(mainHandCharges > 0 and mainHandCharges or nil)
		b:SetID(MAIN_HAND_SLOT)
		b:Show()

		numEnchants = numEnchants + 1
	end

	if hasOffHandEnchant then
		local b = buttons[hasMainHandEnchant and 2 or 1]

		b.expires = GetTime() + (offHandExpiration / 1000)
		b.icon:SetTexture(GetInventoryItemTexture("player", OFF_HAND_SLOT))

		b.arg1, b.arg2 = nil, nil
		if tempEnchantKeywords and db.showTempEnchantSources then
			self.tooltip:SetInventoryItem("player", OFF_HAND_SLOT)
			local tempEnchantString, tempEnchantFindFunc = FindTempEnchantString()
			if tempEnchantString then
				local icon, arg1, arg2 = tempEnchantFindFunc(tempEnchantString)
				if icon and icon ~= "" then
					b.icon:SetTexture(icon)
					b.arg1 = arg1
					b.arg2 = arg2
				end
			end
		end

		b.count:SetText(offHandCharges > 0 and offHandCharges or nil)
		b:SetID(OFF_HAND_SLOT)
		b:Show()

		numEnchants = numEnchants + 1
	end

	if #buttons > numEnchants then
		for i = numEnchants + 1, #buttons do
			local f = buttons[i]
			f.icon:SetTexture()
			f.count:SetText()
			f.arg1, f.arg2, f.tempEnchantString, f.expires = nil, nil, nil, nil
			f:Hide()
		end
	end

	if numEnchants > 0 then
		PhanxBuffFrame.buttons[1]:SetPoint("TOPRIGHT", buttons[numEnchants], "TOPLEFT", -db.buffSpacing, 0)
	else
		PhanxBuffFrame.buttons[1]:SetPoint("TOPRIGHT", PhanxBuffFrame)
	end
end

------------------------------------------------------------------------

local counter = 0
function PhanxTempEnchantFrame:OnUpdate(elapsed)
	counter = counter + elapsed
	if counter > 0.1 then
		if dirty then
			self:UpdateTempEnchants()
			dirty = false
		end
		for i, button in ipairs(buttons) do
			if not button:IsShown() then break end

			if button.expires and button.expires > 0 then
				local remaining = button.expires - GetTime()
				if remaining < 0 then
					dirty = true
				elseif remaining <= 30.5 then
					button.timer:SetText( math.floor(remaining + 0.5) )
				else
					button.timer:SetText()
				end
			else
				button.timer:SetText()
			end
		end
		counter = 0
	end
end

------------------------------------------------------------------------

function PhanxTempEnchantFrame:BAG_UPDATE()
	bagsDirty = true
end

function PhanxTempEnchantFrame:SPELLS_CHANGED()
	spellsDirty = true
end

function PhanxTempEnchantFrame:UNIT_INVENTORY_CHANGED(unit)
	if unit == "player" then
		dirty = true
	end
end

function PhanxTempEnchantFrame:UNIT_ENTERING_VEHICLE(unit)
	if unit == "player" then
		inVehicle = true
		self:Hide()
		PhanxBuffFrame.buttons[1]:SetPoint("TOPRIGHT", PhanxBuffFrame)
	end
end

function PhanxTempEnchantFrame:UNIT_EXITING_VEHICLE(unit)
	if unit == "player" then
		inVehicle = nil
		dirty = true
		self:Show()
	end
end

function PhanxTempEnchantFrame:PLAYER_ENTERING_WORLD()
	local inVehicleNow = UnitInVehicle("player")
	if inVehicle and not inVehicleNow then
		return self:UNIT_EXITING_VEHICLE("player")
	elseif inVehicleNow and not inVehicle then
		return self:UNIT_ENTERING_VEHICLE("player")
	end
	dirty = true
end

PhanxTempEnchantFrame:SetScript("OnEvent", function(self, event, unit)
	return self[event] and self[event](self, unit)
end)

------------------------------------------------------------------------
--	TinyGratuity, ripped from CrowBar by Ammo

if tempEnchantKeywords then
	PhanxTempEnchantFrame.tooltip = CreateFrame("GameTooltip")
	PhanxTempEnchantFrame.tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

	local lcache, rcache = { }, { }
	for i = 1, 30 do
		lcache[i], rcache[i] = PhanxTempEnchantFrame.tooltip:CreateFontString(), PhanxTempEnchantFrame.tooltip:CreateFontString()
		lcache[i]:SetFontObject(GameFontNormal)
		rcache[i]:SetFontObject(GameFontNormal)
		PhanxTempEnchantFrame.tooltip:AddFontStrings(lcache[i], rcache[i])
	end

	PhanxTempEnchantFrame.tooltip.L = setmetatable({ }, {
		__index = function(t, key)
			if PhanxTempEnchantFrame.tooltip:NumLines() >= key and lcache[key] then
				local v = lcache[key]:GetText()
				t[key] = v
				return v
			end
			return nil
		end,
	})

	local origSetBagItem = PhanxTempEnchantFrame.tooltip.SetBagItem
	PhanxTempEnchantFrame.tooltip.SetBagItem = function(self, ...)
		self:ClearLines()
		for i in pairs(self.L) do
			self.L[i] = nil
		end
		if not self:IsOwned(WorldFrame) then
			self:SetOwner(WorldFrame, "ANCHOR_NONE")
		end
		return origSetBagItem(self, ...)
	end

	local origSetInventoryItem = PhanxTempEnchantFrame.tooltip.SetInventoryItem
	PhanxTempEnchantFrame.tooltip.SetInventoryItem = function(self, ...)
		self:ClearLines()
		for i in pairs(self.L) do
			self.L[i] = nil
		end
		if not self:IsOwned(WorldFrame) then
			self:SetOwner(WorldFrame, "ANCHOR_NONE")
		end
		return origSetInventoryItem(self, ...)
	end
end

------------------------------------------------------------------------

function PhanxTempEnchantFrame:Load()
	if db then return end

	db = PhanxBuffsDB

	self:SetPoint("TOPRIGHT", PhanxBuffFrame)
	self:SetWidth(db.buffSize * 2 + db.buffSpacing)
	self:SetHeight(db.buffSize)

	dirty = true
	self:SetScript("OnUpdate", self.OnUpdate)

	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("SPELLS_CHANGED")
	self:RegisterEvent("UNIT_ENTERING_VEHICLE")
	self:RegisterEvent("UNIT_EXITING_VEHICLE")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
end
