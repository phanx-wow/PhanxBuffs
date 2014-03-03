--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
----------------------------------------------------------------------]]

local PhanxTempEnchantFrame = CreateFrame("Frame", "PhanxTempEnchantFrame", UIParent)

local db

local enchants = { }
local _, playerClass = UnitClass("player")
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
			PhanxTempEnchantFrame:Update()
			bagsDirty = nil
		end
		GameTooltip:SetBagItem(self.arg1, self.arg2)
		remaining = self.expires - GetTime()
	elseif self.arg1 then
		if spellsDirty then
			PhanxTempEnchantFrame:Update()
			spellsDirty = nil
		end
		GameTooltip:SetSpellBookItem(self.arg1, BOOKTYPE_SPELL)
		remaining = self.expires - GetTime()
	else
		GameTooltip:SetInventoryItem("player", self:GetID())
	end
	if remaining then
		if remaining > 59 then
			GameTooltip:AddLine(format(L["%d minutes remaining"], floor((remaining / 60) + 0.5)))
		else
			GameTooltip:AddLine(format(L["%d seconds remaining"], floor(remaining + 0.5)))
		end
		GameTooltip:Show()
	end
end

local function button_OnLeave()
	GameTooltip:Hide()
end

local function button_OnClick(self)
	local id = self:GetID()
	local button = "TempEnchant" .. (id - 15)
	_G[button]:SetID(id)
	PhanxBuffsCancelButton:SetMacro(self, self.icon:GetTexture(), "/click " .. button .. " RightButton")
end

local buttons = setmetatable({ }, { __index = function(t, i)
	local button = ns.CreateAuraIcon(PhanxTempEnchantFrame)
	button:SetWidth(db.buffSize)
	button:SetHeight(db.buffSize)
	button:SetScript("OnEnter", button_OnEnter)
	button:SetScript("OnLeave", button_OnLeave)
	button:SetScript("OnClick", button_OnClick)

	if PhanxBorder then
		button:SetBorderColor(180 / 255, 76 / 255, 1) -- 118 / 255, 47 / 255, 170 / 255)
	else
		button.border = button:CreateTexture(nil, "BORDER")
		button.border:SetPoint("TOPLEFT", button, -2, 2)
		button.border:SetPoint("BOTTOMRIGHT", button, 2, -2)
		button.border:SetTexture("Interface\\Buttons\\UI-TempEnchant-Border")
	end

	t[i] = button
	PhanxTempEnchantFrame:UpdateLayout()
	return button
end })

PhanxTempEnchantFrame.buttons = buttons

------------------------------------------------------------------------

function PhanxTempEnchantFrame:UpdateLayout()
	local anchorH = db.buffAnchorH
	local anchorV = db.buffAnchorV
	local size = db.buffSize
	local spacing = db.buffSpacing

	local fontFace = GetFontFile(db.fontFace)
	local fontScale = db.fontScale
	local fontOutline = db.fontOutline

	for i = 1, #buttons do
		local x = (spacing + size) * (i - 1) * (anchorH == "LEFT" and 1 or -1)

		local button = buttons[i]
		button:ClearAllPoints()
		button:SetPoint(anchorV .. anchorH, self, anchorV .. anchorH, x, 0)
		button:SetWidth(size)
		button:SetHeight(size)

		button.count:SetFont(fontFace, 18 * fontScale, fontOutline)
		button.timer:SetFont(fontFace, 14 * fontScale, fontOutline)
	end

	self:ClearAllPoints()
	self:SetPoint(anchorV .. anchorH, PhanxBuffFrame, anchorV .. anchorH, 0, 0)
	self:SetWidth((size * 2) + spacing)
	self:SetHeight(size)
end

------------------------------------------------------------------------

local function FindTempEnchantItem(findString)
	--print("FindTempEnchantItem", findString)
	findString = strlower(strtrim(gsub(findString, "%(.-%)", "")))
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local icon, _, _, _, _, _, link = GetContainerItemInfo(bag, slot)
			if link then
				local name = strmatch(link, "%[(.+)%]")
				if strmatch(strlower(name), findString) then
					return icon, bag, slot
				end
			end
		end
	end
end

local function FindTempEnchantSpell(findString)
	--print("FindTempEnchantSpell", findString)
	local findRank = strmatch(findString, "%d+")
	findString = strtrim(gsub(findString, "%d+", ""))

	local i = 1
	while true do
		local spellName, spellRank = GetSpellBookItemName(i, BOOKTYPE_SPELL)
		if not spellName then break end
		if spellName:match(findString) then
			if findRank then
				if spellRank then
					spellRank = strmatch(spellRank, "%d+")
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
if playerClass == "SHAMAN" then
	tempEnchantKeywords = {
		[L["Earthliving"]] = GetSpellInfo(51730),
		[L["Flametongue"]] = GetSpellInfo(8024),
		[L["Frostbrand"]]  = GetSpellInfo(8033),
		[L["Rockbiter"]]   = GetSpellInfo(8017),
		[L["Windfury"]]    = GetSpellInfo(8232),
	}
elseif playerClass == "ROGUE" then
	tempEnchantKeywords = {
		[L["Anesthetic Poison"]] = true,
		[L["Crippling Poison"]] = true,
		[L["Deadly Poison"]] = true,
		[L["Leeching Poison"]] = true,
		[L["Mind-Numbing Poison"]] = true,
		[L["Paralytic Poison"]] = true,
		[L["Wound Poison"]] = true,
	}
end

local function FindTempEnchantString()
	for i = 1, PhanxTempEnchantFrame.tooltip:NumLines() do
		local line = PhanxTempEnchantFrame.tooltip.L[i]
		for k, v in pairs(tempEnchantKeywords) do
			if strmatch(line, k) then
				if type(v) == "string" then
					local rank = line:match("( %d+)") or ""
					--print("Found temp enchant string " .. k .. " (spell " .. v .. ") rank " .. rank)
					return v .. rank, FindTempEnchantSpell
				else
					--print("Found temp enchant string " .. k .. " (item)")
					return k, FindTempEnchantItem
				end
			end
		end
	end
end

------------------------------------------------------------------------

function PhanxTempEnchantFrame:Update()
	local mainHandEnchant, mainHandExpiration, mainHandCharges,
		offHandEnchant, offHandExpiration, offHandCharges,
		thrownEnchant, thrownExpiration, thrownCharges = GetWeaponEnchantInfo()

	local numEnchants = 0

	if mainHandEnchant then
		numEnchants = numEnchants + 1
		local button = buttons[numEnchants]

		button.expires = GetTime() + (mainHandExpiration / 1000)
		button.icon:SetTexture(GetInventoryItemTexture("player", MAIN_HAND_SLOT))

		button.arg1, button.arg2 = nil, nil
		if tempEnchantKeywords and db.showTempEnchantSources then
			self.tooltip:SetInventoryItem("player", MAIN_HAND_SLOT)
			local tempEnchantString, tempEnchantFindFunc = FindTempEnchantString()
			if tempEnchantString then
				local icon, arg1, arg2 = tempEnchantFindFunc(tempEnchantString)
				if icon and icon ~= "" then
					--print("Found temp enchant:", tempEnchantString, arg1, arg2)
					button.icon:SetTexture(icon)
					button.arg1 = arg1
					button.arg2 = arg2
				end
			end
		end

		button.count:SetText(mainHandCharges > 0 and mainHandCharges or nil)
		button:SetID(MAIN_HAND_SLOT)
		button:Show()
	end

	if offHandEnchant then
		numEnchants = numEnchants + 1
		local b = buttons[numEnchants]

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

	self.numEnchants = numEnchants
	PhanxBuffFrame:UpdateLayout()
end

------------------------------------------------------------------------

local timerGroup = PhanxTempEnchantFrame:CreateAnimationGroup()
local timer = timerGroup:CreateAnimation()
timer:SetOrder(1)
timer:SetDuration(0.1) -- how often you want it to finish
-- timer:SetMaxFramerate(25) -- use this to throttle
timerGroup:SetScript("OnFinished", function(self, requested)
	if dirty then
		PhanxTempEnchantFrame:Update()
		dirty = false
	end
	for i, button in ipairs(buttons) do
		if not button:IsShown() then break end
		if button.expires and button.expires > 0 then
			local remaining = button.expires - GetTime()
			if remaining < 0 then
				dirty = true
			elseif remaining <= db.maxTimer then
				if remaining > 3600 then
					button.timer:SetFormattedText( HOUR_ONELETTER_ABBR, floor( ( remaining / 60 ) + 0.5 ) )
				elseif remaining > 60 then
					button.timer:SetFormattedText( MINUTE_ONELETTER_ABBR, floor( ( remaining / 60 ) + 0.5 ) )
				else
					button.timer:SetText( floor( remaining + 0.5 ) )
				end
			else
				button.timer:SetText()
			end
		else
			button.timer:SetText()
		end
	end
	self:Play() -- start it over again
end)

------------------------------------------------------------------------

function PhanxTempEnchantFrame:BAG_UPDATE()
	bagsDirty = true
end

function PhanxTempEnchantFrame:SPELLS_CHANGED()
	spellsDirty = true
end

function PhanxTempEnchantFrame:UNIT_INVENTORY_CHANGED(unit)
	dirty = true
end

function PhanxTempEnchantFrame:UNIT_ENTERED_VEHICLE(unit)
	if UnitHasVehicleUI(unit) then
		inVehicle = true
		self:Hide()
		PhanxBuffFrame.buttons[1]:SetPoint(db.buffAnchorV .. db.buffAnchorH, PhanxBuffFrame)
	end
end

function PhanxTempEnchantFrame:UNIT_EXITED_VEHICLE(unit)
	inVehicle = nil
	dirty = true
	self:Show()
end

function PhanxTempEnchantFrame:PET_BATTLE_OPENING_START()
	self:Hide()
end

function PhanxTempEnchantFrame:PET_BATTLE_CLOSE()
	dirty = true
	self:Show()
end

function PhanxTempEnchantFrame:PLAYER_ENTERING_WORLD()
	local inVehicleNow = UnitHasVehicleUI("player")
	if inVehicle and not inVehicleNow then
		return self:UNIT_EXITED_VEHICLE("player")
	elseif inVehicleNow and not inVehicle then
		return self:UNIT_ENTERED_VEHICLE("player")
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

	self:PLAYER_ENTERING_WORLD()

	dirty = true
	timerGroup:Play()

	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("SPELLS_CHANGED")
	self:RegisterEvent("PET_BATTLE_OPENING_START")
	self:RegisterEvent("PET_BATTLE_CLOSE")
	self:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	self:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
	self:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
end