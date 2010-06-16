--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
----------------------------------------------------------------------]]

PhanxBuffFrame = CreateFrame("Frame")

local db
local ignoreBuffs = {
	["Fake Buff"] = true,
}

local buffs = { }
local buffUnit = "player"

local _, ns = ...
local GetFontFile = ns.GetFontFile

local LibButtonFacade

------------------------------------------------------------------------

local unitNames = setmetatable({ }, { __index = function(t, unit)
	if not unit then return end

	local name = UnitName(unit)
	if not name then return end

	local _, class = UnitClass(unit)
	if not class then return name end

	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
	if not color then return name end

	return string.format("Cast by |cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, name)
end })

local function button_OnEnter(self)
	local buff = buffs[self:GetID()]
	if not buff then return end

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
	GameTooltip:SetUnitAura(buffUnit, buff.index, "HELPFUL")

	if db.showBuffSources then
		local caster = unitNames[buff.caster]
		if caster then
			GameTooltip:AddLine(caster)
			GameTooltip:Show()
		end
	end
end

local function button_OnLeave()
	GameTooltip:Hide()
end

local function button_OnClick(self)
	local buff = buffs[self:GetID()]
	if not buff then return end

	CancelUnitBuff(buffUnit, buff.index, "HELPFUL")
end

local buttons = setmetatable({ }, { __index = function(t, i)
	if type(i) ~= "number" then return print("NON-NUMERIC INDEX " .. tostring(i) .. " SPECIFIED WTF") end

	local f = CreateFrame("Button", nil, PhanxBuffFrame)
	f:SetID(i)
	f:SetWidth(db.buffSize)
	f:SetHeight(db.buffSize)
	f:Show()

	if i == 1 then
		f:SetPoint("TOPRIGHT")
	else
		f:SetPoint("RIGHT", t[i - 1], "LEFT", -db.buffSpacing, 0)
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

	if LibButtonFacade then
		local noop = function() return end
		local fake = {
			ClearAllPoints = noop,
			GetFrameLevel = noop,
			GetTextColor = noop,
			Hide = noop,
			SetDrawLayer = noop,
			SetFrameLevel = noop,
			SetHeight = noop,
			SetParent = noop,
			SetPoint = noop,
			SetTextColor = noop,
			SetTexture = noop,
			SetVertexColor = noop,
			SetWidth = noop,
			Show = noop,
		}
		LibButtonFacade:Group("PhanxBuffs"):AddButton(f, {
			Count = f.count,
			HotKey = f.timer,
			Icon = f.icon,
			AutoCast = fake,
			AutoCastable = false,
			Border = fake,
			Checked = false,
			Cooldown = fake,
			Flash = false,
			Disabled = false,
			Highlight = false,
			Name = false,
			Pushed = false,
		})
	elseif PhanxBorder then
		PhanxBorder.AddBorder(f, 8)
		f.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end

	t[i] = f
	return f
end })

PhanxBuffFrame.buttons = buttons

------------------------------------------------------------------------

local function BuffSort(a, b)
	if a.duration == 0 then
		if b.duration == 0 then
			-- both timeless, sort by name REVERSE
			return a.name < b.name
		else
			-- a timeless, b not
			return true
		end
	else
		if b.duration == 0 then
			-- b timeless, a not
			return false
		else
			-- neither timeless, sort by expiry time
			return a.expires > b.expires
		end
	end
end

------------------------------------------------------------------------

local tablePool = { }

local function newTable()
	local t = next(tablePool) or {}
	tablePool[t] = nil
	return t
end

local function remTable(t)
	if type(t) == "table" then
		for k, v in pairs(t) do
			t[k] = nil
		end
		t[true] = true
		t[true] = nil
		tablePool[t] = true
	end
	return nil
end

------------------------------------------------------------------------

function PhanxBuffFrame:UpdateBuffs()
	for i, t in ipairs(buffs) do
		buffs[i] = remTable(t)
	end

	local i = 1
	while true do
		local name, _, icon, count, kind, duration, expires, caster, _, _, spellID = UnitAura(buffUnit, i, "HELPFUL")
		if not name then break end

		if not db.ignoreBuffs[name] then
			local n = #buffs + 1
			buffs[n] = newTable()
			local t = buffs[n]

			t.name = name
			t.icon = icon
			t.count = count
			t.kind = kind
			t.duration = duration or 0
			t.expires = expires
			t.caster = caster
			t.spellID = spellID
			t.index = i
		end

		i = i + 1
	end

	if #buffs > (i - 1) then
		for j = i, #buffs do
			buffs[j] = nil
		end
	end

	table.sort(buffs, BuffSort)

	for i, buff in ipairs(buffs) do
		local f = buttons[i]
		f.icon:SetTexture(buff.icon)

		if buff.count > 0 then
			f.count:SetText(buff.count)
		else
			f.count:SetText()
		end

		f:Show()
	end

	if #buttons > #buffs then
		for i = #buffs + 1, #buttons do
			local f = buttons[i]
			f.icon:SetTexture()
			f.count:SetText()
			f:Hide()
		end
	end
end

------------------------------------------------------------------------

local counter, dirty = 0
function PhanxBuffFrame:OnUpdate(elapsed)
	counter = counter + elapsed
	if counter > 0.1 then
		if dirty then
			self:UpdateBuffs()
			dirty = false
		end
		for i, button in ipairs(buttons) do
			if not button:IsShown() then break end

			local buff = buffs[button:GetID()]
			if buff then
				if buff.expires > 0 then
					local remaining = buff.expires - GetTime()
					if remaining < 0 then
						-- bugged out, kill it
						remTable( table.remove(buffs, button:GetID()) )
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
		end
		counter = 0
	end
end

------------------------------------------------------------------------

PhanxBuffFrame:SetScript("OnEvent", function(self, event, unit)
	if event == "UNIT_AURA" then
		if unit == buffUnit then
			dirty = true
		end
	return end
	if event == "PLAYER_ENTERING_WORLD" then
		buffUnit = UnitInVehicle("player") and "vehicle" or "player"
		dirty = true
	return end
	if event == "UNIT_ENTERING_VEHICLE" then
		if unit == "player" then
			buffUnit = "vehicle"
			dirty = true
		end
	return end
	if event == "UNIT_EXITING_VEHICLE" then
		if unit == "player" then
			buffUnit = "player"
			dirty = true
		end
	return end
end)

------------------------------------------------------------------------

function PhanxBuffFrame:Load()
	if db then return end

	db = PhanxBuffsDB
	for k, v in pairs(ignoreBuffs) do
		db.ignoreBuffs[k] = v
	end

	LibButtonFacade = LibStub("LibButtonFacade", true)

	self:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -5, PhanxBorder and 1 or 0)
	self:SetWidth(UIParent:GetWidth() - Minimap:GetWidth() - 45)
	self:SetHeight(db.buffSize)

	dirty = true
	self:SetScript("OnUpdate", self.OnUpdate)

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_ENTERING_VEHICLE")
	self:RegisterEvent("UNIT_EXITING_VEHICLE")
	self:RegisterEvent("UNIT_AURA")
end
