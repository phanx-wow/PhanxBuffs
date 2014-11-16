--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx. All rights reserved.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs

	Please DO NOT upload this addon to other websites, or post modified
	versions of it. However, you are welcome to include a copy of it
	WITHOUT CHANGES in compilations posted on Curse and/or WoWInterface.
	You are also welcome to use any/all of its code in your own addon, as
	long as you do not use my name or the name of this addon ANYWHERE in
	your addon, including its name, outside of an optional attribution.
----------------------------------------------------------------------]]

local PhanxBuffFrame = CreateFrame("Frame", "PhanxBuffFrame", UIParent)

local _, ns = ...
local GetFontFile = ns.GetFontFile
local L = ns.L
L["Cast by |cff%02x%02x%02x%s|r"] = gsub(L["Cast by %s"], "%%s", "|cff%%02x%%02x%%02x%%s|r")

local db, ignore
local formIndex, formName, formIcon, formSpellID
local buffUnit = "player"
local buffs = {}

local MAX_BUFFS = 40

local ceil, floor, next, pairs, sort, tonumber, type = math.ceil, math.floor, next, pairs, table.sort, tonumber, type -- Lua functions
local GetSpellInfo, UnitAura = GetSpellInfo, UnitAura -- API functions
local RaidBuffTray_Update, ShouldShowConsolidatedBuffFrame = RaidBuffTray_Update, ShouldShowConsolidatedBuffFrame -- FrameXML functions
local ConsolidatedBuffsCount = ConsolidatedBuffsCount -- FrameXML objects

local fakes = {
	[(GetSpellInfo(103985))] = 103985, -- MONK: Stance of the Fierce Tiger -- show instead of halfassed "Windwalking" buff
	[(GetSpellInfo(115069))] = 115069, -- MONK: Stance of the Sturdy Ox
	[(GetSpellInfo(115070))] = 115070, -- MONK: Stance of the Wise Serpent
	[(GetSpellInfo(154436))] = 154436, -- MONK: Stance of the Spirited Crane
	[(GetSpellInfo(105361))] = 105361, -- PALADIN: Seal of Command
	[(GetSpellInfo(20165))]  = 20165,  -- PALADIN: Seal of Insight
	[(GetSpellInfo(20154))]  = 20154,  -- PALADIN: Seal of Righteousness
	[(GetSpellInfo(31801))]  = 31801,  -- PALADIN: Seal of Truth
}

------------------------------------------------------------------------

local tablePool = {}

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

local unitNames = setmetatable({}, { __index = function(t, unit)
	if not unit then return end

	local name = UnitName(unit)
	if not name then return end

	local _, class = UnitClass(unit)
	if not class then return format(L["Cast by %s"], name) end

	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
	if not color then return format(L["Cast by %s"], name) end

	return format(L["Cast by |cff%02x%02x%02x%s|r"], color.r * 255, color.g * 255, color.b * 255, name)
end })

local function button_OnUpdate(self) -- only used for consolidated buffs icon
	if not self:IsMouseOver(6, -6, -6, 6) and not ConsolidatedBuffsTooltip:IsMouseOver() then
		ConsolidatedBuffsTooltip:Hide()
		self:SetScript("OnUpdate", nil)
	end
end

local function button_OnHide(self) -- only used for consolidated buffs icon
	ConsolidatedBuffsTooltip:Hide()
	self:SetScript("OnUpdate", nil)
end

local function button_OnEnter(self)
	local anchorH = db.buffAnchorH
	local anchorV = db.buffAnchorV
	local anchorPoint = (anchorV == "TOP" and "BOTTOM" or "TOP") .. anchorH

	local id = self:GetID()
	if id == 0 then
		RaidBuffTray_Update()
		ConsolidatedBuffsTooltip:ClearAllPoints()
		ConsolidatedBuffsTooltip:SetPoint(anchorV .. anchorH, self, anchorPoint, 0, -6)
		ConsolidatedBuffsTooltip:Show()
		self:SetScript("OnUpdate", button_OnUpdate)
	return end

	local buff = buffs[id]
	if not buff then return end

	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint(anchorV .. anchorH, self, anchorPoint, 0, -6)
	if buff.isFake then
		local text = rawget(L, formSpellID)
		if text then
			GameTooltip:AddLine(formName)
			GameTooltip:AddLine(text, 1, 1, 1, true)
			GameTooltip:Show()
		else
			GameTooltip:SetShapeshift(buff.index)
		end
	else
		GameTooltip:SetUnitAura(buffUnit, buff.index, "HELPFUL")
	end

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

local function button_PreClick(self, btn)
	local buff = buffs[self:GetID()]
	if not buff then return end
	if btn == "RightButton" and not InCombatLockdown() and not (IsAltKeyDown() and IsShiftKeyDown()) then
		PhanxBuffsCancelButton:SetMacro(self, buff.icon, "/cancelaura " .. buff.name)
	end
end

local function button_OnClick(self)
	local buff = buffs[self:GetID()]
	if not buff then return end
	if IsAltKeyDown() and IsShiftKeyDown() then
		ignore[buff.name] = true
		print("|cffffcc00PhanxBuffs:|r", format(ns.L["Now ignoring buff: %s"], buff.name))
		self:GetParent():Update()
	end
end

local buttons = setmetatable({}, { __index = function(t, i)
	if type(i) ~= "number" then return end

	local button = ns.CreateAuraIcon(PhanxBuffFrame)
	button:SetWidth(db.buffSize)
	button:SetHeight(db.buffSize)
	button:SetScript("OnEnter", button_OnEnter)
	button:SetScript("OnLeave", button_OnLeave)
	button:SetScript("PreClick", button_PreClick)
	button:SetScript("OnClick", button_OnClick)

	t[i] = button
	PhanxBuffFrame:UpdateLayout()
	return button
end })

PhanxBuffFrame.buttons = buttons

------------------------------------------------------------------------

function PhanxBuffFrame:UpdateLayout()
	local anchorH = db.buffAnchorH
	local anchorV = db.buffAnchorV
	local size = db.buffSize
	local spacing = db.buffSpacing
	local cols = db.buffColumns
	local rows = ceil(MAX_BUFFS / cols)

	local fontFace = GetFontFile(db.fontFace)
	local fontScale = db.fontScale
	local fontOutline = db.fontOutline

	local offset = PhanxTempEnchantFrame.numEnchants or 0
	for i = 1, #buttons do
		local button = buttons[i]
		local j = i + offset

		local col = (j - 1) % cols
		local row = ceil(j / cols) - 1

		local x = floor(col * (spacing + size) * (anchorH == "LEFT" and 1 or -1) + 0.5)
		local y = floor(row * (spacing + (size * 1.5)) + 0.5)

		button:ClearAllPoints()
		button:SetWidth(size)
		button:SetHeight(size)
		button:SetPoint(anchorV .. anchorH, self, anchorV .. anchorH, x, anchorV == "BOTTOM" and y or -y)

		button.count:SetFont(fontFace, 18 * fontScale, fontOutline)
		button.timer:SetFont(fontFace, 14 * fontScale, fontOutline)

		if fontOutline == "THICKOUTLINE" then
			button.count:SetPoint("CENTER", button, "TOP", 2, -1)
			button.timer:SetPoint("TOP", button, "BOTTOM", 2, -1)
		elseif fontOutline == "OUTLINE" then
			button.count:SetPoint("CENTER", button, "TOP", 1, 0)
			button.timer:SetPoint("TOP", button, "BOTTOM", 1, 0)
		else
			button.count:SetPoint("CENTER", button, "TOP", 0, 0)
			button.timer:SetPoint("TOP", button, "BOTTOM", 0, 0)
		end
	end

	self:ClearAllPoints()
	if db.buffPoint and db.buffX and db.buffY then
		self:SetPoint(db.buffPoint, UIParent, db.buffX, db.buffY)
	else
		self:SetPoint("TOPRIGHT", UIParent, -70 - floor(Minimap:GetWidth() + 0.5), -15)
	end
	self:SetWidth((size * cols) + (spacing * (cols - 1)))
	self:SetHeight((size * rows) + (spacing * (rows - 1)))
end

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

function PhanxBuffFrame:Update()
	for i = 1, #buffs do
		buffs[i] = remTable(buffs[i])
	end

	local consolidate = ShouldShowConsolidatedBuffFrame()

	for i = 1, 100 do
		local name, _, icon, count, kind, duration, expires, caster, _, shouldConsolidate, spellID = UnitAura(buffUnit, i, "HELPFUL")
		if not name or not icon or icon == "" then break end

		-- Hardcode exception for "Windwalking" buff, show Stance of the Fierce Tiger fake buff instead
		if not ignore[name] and not (spellID == 166646 and db.showFakeBuffs) and not (consolidate and shouldConsolidate) then
			local t = newTable()

			t.name = name
			t.icon = icon
			t.count = count
			t.kind = kind
			t.duration = duration or 0
			t.expires = expires
			t.caster = caster
			t.spellID = spellID
			t.index = i

			buffs[#buffs + 1] = t
		end
	end

	if formSpellID and db.showFakeBuffs then
		local t = newTable()

		local _, _, icon = GetSpellInfo(formSpellID)

		t.name = formName
		t.icon = icon or formIcon
		t.count = 1
		-- no type
		t.duration = 0
		t.expires = 0
		t.caster = "player"
		t.spellID = formID
		t.index = formIndex
		t.isFake = true

		buffs[#buffs + 1] = t
	end

	sort(buffs, BuffSort)

	if consolidate then
		RaidBuffTray_Update()

		local f = buttons[1]
		f:SetID(0)
		f:SetScript("OnHide", button_OnHide)
		f.icon:SetTexture("Interface\\Buttons\\BuffConsolidation")
		f.icon:SetTexCoord(21/128, 44/128, 20/64, 43/64)
		local have, total = strsplit("/", ConsolidatedBuffsCount:GetText() or "")
		have, total = have and tonumber(have) or 0, total and tonumber(total) or 0
		if have < total then
			f.count:SetFormattedText("|cffffaaaa%s", total - have)
		else
			f.count:SetText()
		end
		f.timer:SetText()
		f:Show()
	else
		local f = buttons[1]
		f:SetScript("OnHide", nil)
		f.icon:SetTexCoord(buttons[2].icon:GetTexCoord())
	end

	local offset = consolidate and 1 or 0
	for i = 1, #buffs do
		local buff = buffs[i]
		local f = buttons[i + offset]
		f:SetID(i)
		f.icon:SetTexture(buff.icon)
		f.count:SetText(buff.count > 1 and buff.count or nil)
		f:Show()
	end

	if #buttons > #buffs then
		for i = #buffs + 1 + offset, #buttons do
			local f = buttons[i]
			f.icon:SetTexture()
			f.count:SetText()
			f:Hide()
		end
	end
end

------------------------------------------------------------------------

local dirty

local timerGroup = PhanxBuffFrame:CreateAnimationGroup()
local timer = timerGroup:CreateAnimation()
timer:SetOrder(1)
timer:SetDuration(0.1) -- how often you want it to finish
-- timer:SetMaxFramerate(20) -- use this to throttle
timerGroup:SetScript("OnFinished", function(self, requested)
	if dirty then
		PhanxBuffFrame:Update()
		dirty = false
	end
	local max = db.maxTimer
	for i = 1, #buttons do
		local button = buttons[i]
		if not button:IsShown() then break end
		local buff = buffs[button:GetID()]
		if buff then
			if buff.expires > 0 then
				local remaining = buff.expires - GetTime()
				if remaining < 0 then
					-- bugged out, kill it
					remTable(tremove(buffs, button:GetID()))
					dirty = true
				elseif remaining <= max then
					if remaining > 3600 then
						button.timer:SetFormattedText(HOUR_ONELETTER_ABBR, floor((remaining / 60) + 0.5))
					elseif remaining > 60 then
						button.timer:SetFormattedText(MINUTE_ONELETTER_ABBR, floor((remaining / 60) + 0.5))
					else
						button.timer:SetText(floor(remaining + 0.5))
					end
				else
					button.timer:SetText()
				end
			else
				button.timer:SetText()
			end
		end
	end
	self:Play() -- start it over again
end)

------------------------------------------------------------------------

PhanxBuffFrame:SetScript("OnEvent", function(self, event, unit)
	if event == "UNIT_AURA" then
		if unit == buffUnit then
			dirty = true
		end
	elseif event == "UPDATE_SHAPESHIFT_FORM" then
		formIndex = GetShapeshiftForm()
		if formIndex > 0 then
			formIcon, formName = GetShapeshiftFormInfo(formIndex)
			formSpellID = fakes[formName]
		else
			formIcon, formName, formSpellID = nil, nil, nil
		end
		dirty = true
	elseif event == "PLAYER_ENTERING_WORLD" then
		if UnitHasVehicleUI("player") then
			buffUnit = "vehicle"
		else
			buffUnit = "player"
		end
		self:GetScript("OnEvent")(self, "UPDATE_SHAPESHIFT_FORM")
	elseif event == "UNIT_ENTERED_VEHICLE" then
		if UnitHasVehicleUI("player") then
			buffUnit = "vehicle"
		end
		dirty = true
	elseif event == "UNIT_EXITED_VEHICLE" then
		buffUnit = "player"
		dirty = true
	elseif event == "PET_BATTLE_OPENING_START" then
		self:Hide()
	elseif event == "PET_BATTLE_CLOSE" then
		dirty = true
		self:Show()
	end
end)

------------------------------------------------------------------------

function PhanxBuffFrame:Load()
	if db then return end

	db = PhanxBuffsDB
	ignore = PhanxBuffsIgnoreDB.buffs

	-- populate L strings for warrior stance fake buffs
	GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	for id in pairs({ [2457] = true, [2458] = true, [71] = true }) do
		GameTooltip:SetSpellByID(id)
		L[id] = strmatch(GameTooltipTextLeft3:GetText() or "TRANSLATION SERVER ERROR", "\r\n\r\n(.+)")
	end
	GameTooltip:Hide()

	ConsolidatedBuffs:Hide()
	ConsolidatedBuffs:SetScript("OnShow", ConsolidatedBuffs.Hide)

	ConsolidatedBuffsTooltip:SetScript("OnUpdate", nil)
	ConsolidatedBuffsTooltip:SetScale(1)

	local maxWidthEven, maxWidthOdd = 70, 70
	for i = 1, NUM_LE_RAID_BUFF_TYPES do
		local line = ConsolidatedBuffsTooltip["Buff"..i]
		local text = gsub(line.labelString, "%-?%s*[\r\n]+", "")
		line.labelString = text
		line.label:SetText(text)
		if i % 2 == 0 then
			maxWidthEven = max(maxWidthEven, line.label:GetStringWidth())
		else
			maxWidthOdd = max(maxWidthOdd, line.label:GetStringWidth())
		end
	end
	for i = 1, NUM_LE_RAID_BUFF_TYPES do
		local line = ConsolidatedBuffsTooltip["Buff"..i]
		if i % 2 == 0 then
			line.label:SetWidth(maxWidthEven)
			line:SetWidth(maxWidthEven + 30)
		else
			line.label:SetWidth(maxWidthOdd)
			line:SetWidth(maxWidthOdd + 30)
		end
	end
	ConsolidatedBuffsTooltip:SetWidth(ConsolidatedBuffsTooltip:GetWidth() + (maxWidthEven - 70) + (maxWidthOdd - 70))

	self:GetScript("OnEvent")(self, "PLAYER_ENTERING_WORLD")

	dirty = true
	timerGroup:Play()

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PET_BATTLE_OPENING_START")
	self:RegisterEvent("PET_BATTLE_CLOSE")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	self:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	self:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
	self:RegisterUnitEvent("UNIT_AURA", "player", "vehicle")

	hooksecurefunc("SetCVar", function(k, v)
		if k == "consolidateBuffs" then
			dirty = true
		end
	end)

	self.loaded = true
end