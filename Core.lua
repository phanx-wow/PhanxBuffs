--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2017 Phanx <addons@phanx.net>. All rights reserved.
	https://github.com/Phanx/PhanxBuffs
	https://mods.curse.com/addons/wow/phanxbuffs
	https://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
----------------------------------------------------------------------]]

local ADDON_NAME, ns = ...
local L = ns.L
local db

local defaultDB = {
	buffAnchorH = "RIGHT",
	buffAnchorV = "TOP",
	buffColumns = 20,
	buffSize    = 24,
	buffSpacing = 3,

	debuffAnchorH = "RIGHT",
	debuffAnchorV = "TOP",
	debuffColumns = 10,
	debuffSize    = 48,
	debuffSpacing = 3,

	fontFace    = "Arial Narrow",
	fontOutline = "OUTLINE",
	fontScale   = 1,

	maxTimer = 30,

	showBuffSources = true,

	minimapIcon = {},
}

local defaultIgnore = {
	buffs = {},
	debuffs = {},
}

------------------------------------------------------------------------

local Media = LibStub("LibSharedMedia-3.0")

ns.COUNT_SIZE  = 18
ns.TIMER_SIZE  = 14
ns.SYMBOL_SIZE = 16

ns.auraFrames = {}

------------------------------------------------------------------------

local tablePool = {}

local function newTable()
	local t = next(tablePool) or {}
	tablePool[t] = nil
	return t
end

local function remTable(t)
	if type(t) == "table" then
		tablePool[wipe(t)] = true
	end
end

ns.newTable = newTable
ns.remTable = remTable

------------------------------------------------------------------------

local function GetFontFile(name)
	return Media:Fetch("font", name)
end
ns.GetFontFile = GetFontFile

local function SetButtonFonts(parent, face, outline)
	if not face then face = db.fontFace end
	if not outline then outline = db.fontOutline end

	local file = Media:Fetch("font", face)
	local scale = db.fontScale

	for i = 1, #parent.buttons do
		local button = parent.buttons[i]
		button.count:SetFont(file, ns.COUNT_SIZE * scale, outline)
		button.timer:SetFont(file, ns.TIMER_SIZE * scale, outline)
		if button.symbol then
			button.symbol:SetFont(file, ns.SYMBOL_SIZE * scale, outline)
		end
	end
end
ns.SetButtonFonts = SetButtonFonts

------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		local function initDB(db, defaults)
			if type(db) ~= "table" then db = {} end
			if type(defaults) ~= "table" then return db end
			for k, v in pairs(defaults) do
				if type(v) == "table" then
					db[k] = initDB(db[k], v)
				elseif type(v) ~= type(db[k]) then
					db[k] = v
				end
			end
			return db
		end

		PhanxBuffsDB = initDB(PhanxBuffsDB, defaultDB)
		db = PhanxBuffsDB

		local LDB = LibStub("LibDataBroker-1.1", true)
		if LDB then
			LDB:NewDataObject(ADDON_NAME, {
				type = "launcher",
				icon = "Interface\\Icons\\Ability_Warrior_ShieldMastery",
				OnTooltipShow = function(tooltip)
					tooltip:AddLine(ADDON_NAME, 1, 1, 1)
					tooltip:AddLine(L["Click to lock or unlock the frames."])
					tooltip:AddLine(L["Right-click for options."])
					tooltip:Show()
				end,
				OnClick = function(_, button)
					if button == "RightButton" then
						-- double up to work around Blizz bug
						InterfaceOptionsFrame_OpenToCategory(ns.optionsPanel)
						InterfaceOptionsFrame_OpenToCategory(ns.optionsPanel)
					else
						ns.ToggleFrameLocks()
					end
				end,
			})
		end

		PhanxBuffsIgnoreDB = initDB(PhanxBuffsIgnoreDB, defaultIgnore)

		local function MediaCallback(callbackName, mediaType, mediaName)
			if mediaType == "font" then
				for i = 1, #ns.auraFrames do
					SetButtonFonts(ns.auraFrames[i])
				end
			end
		end
		Media.RegisterCallback(self, "LibSharedMedia_Registered", MediaCallback)
		Media.RegisterCallback(self, "LibSharedMedia_SetGlobal", MediaCallback)
		MediaCallback(event, "font")

		BuffFrame:Hide()
		TemporaryEnchantFrame:Hide()
		BuffFrame:UnregisterAllEvents()

		for i = 1, #ns.auraFrames do
			ns.auraFrames[i]:Initialize()
			ns.auraFrames[i]:ApplySettings()
		end

		if ns.SkinWithMasque then
			ns.SkinWithMasque()
		end

		self:UnregisterAllEvents()
		self:RegisterEvent("PLAYER_LOGOUT")
	else
		local function cleanDB(db, defaults)
			if type(db) ~= "table" then return {} end
			if type(defaults) ~= "table" then return db end
			for k, v in pairs(db) do
				if type(v) == "table" then
					if not next(cleanDB(v, defaults[k])) then
						db[k] = nil
					end
				elseif v == defaults[k] then
					db[k] = nil
				end
			end
			return db
		end
		PhanxBuffsDB = cleanDB(PhanxBuffsDB, defaultDB)
	end
end)

------------------------------------------------------------------------

local cancelButton = CreateFrame("Button", "PhanxBuffsCancelButton", UIParent, "SecureActionButtonTemplate")
cancelButton:SetPoint("CENTER")
cancelButton:SetSize(64, 64)
cancelButton:Hide()

function cancelButton:Setup()
	self:RegisterForClicks("RightButtonUp")
	self:SetAttribute("unit", "player")
	self:SetAttribute("type2", "macro")

	self.overlay = self:CreateTexture(nil, "BACKGROUND")
	self.overlay:SetAllPoints(true)
	self.overlay:SetTexture(1, 0, 0, 0.5)
	self.overlay:Hide()

	self:SetScript("PreClick", function(self, button)
		self.owner:Click(button)
	end)
	
	self:SetScript("PostClick", function(self, button)
		return not InCombatLockdown() and self:Hide()
	end)

	self.Setup = nil
end

function cancelButton:SetMacro(button, macro)
	if InCombatLockdown() then return end
	if self.Setup then self:Setup() end

	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 2)
	self:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
	self:SetFrameLevel(100)

	self.owner = button
	self:SetAttribute("macrotext2", "/stopmacro [mod:alt,mod:shift]\n" .. macro)

	self:Show()
end

cancelButton:SetScript("OnHide", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", UIParent, 0, 0)
	if self.owner then
		self.owner:GetScript(self.owner:IsMouseOver() and "OnEnter" or "OnLeave")(self.owner)
	end
	self.owner = nil
end)

cancelButton:SetScript("OnEnter", function(self)
	if not self.owner then
		return self:Hide()
	end
	self.owner:GetScript("OnEnter")(self.owner)
end)

cancelButton:SetScript("OnLeave", function(self)
	self.owner:GetScript("OnLeave")(self.owner)
end)

cancelButton:RegisterEvent("PLAYER_REGEN_DISABLED")
cancelButton:SetScript("OnEvent", function(self)
	if not InCombatLockdown() then
		self:Hide()
	end
end)

------------------------------------------------------------------------

local function AuraButton_OnLeave(self)
	if not self:IsMouseOver() then
		GameTooltip:Hide()
		if PhanxBuffsCancelButton.owner == self and not InCombatLockdown() then
			PhanxBuffsCancelButton:Hide()
		end
	end
end

local function CreateAuraButton(self)
	local button = CreateFrame("Button", nil, self)
	button.owner = self

	button:Hide()
	button:EnableMouse(true)
	button:RegisterForClicks("RightButtonUp")
	button:SetScript("OnLeave", AuraButton_OnLeave)

	button.icon = button:CreateTexture(nil, "BACKGROUND")
	button.icon:SetAllPoints(button)

	button.count = button:CreateFontString(nil, "OVERLAY")
	button.count:SetPoint("CENTER", button, "TOP")
	button.count:SetShadowOffset(1, -1)

	button.timer = button:CreateFontString(nil, "OVERLAY")
	button.timer:SetPoint("TOP", button, "BOTTOM")
	button.timer:SetShadowOffset(1, -1)

	local file, scale, outline = GetFontFile(), db.fontScale, db.fontOutline
	button.count:SetFont(file, ns.COUNT_SIZE * scale, outline)
	button.timer:SetFont(file, ns.TIMER_SIZE * scale, outline)

	if PhanxBorder and (db.noMasque or not LibStub("Masque", true)) then
		PhanxBorder.AddBorder(button)
		button.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end

	if self.PostCreateAuraButton then
		self:PostCreateAuraButton(button)
	end

	return button
end

------------------------------------------------------------------------

local function AuraFrame_UpdateLayout(self)
	local anchorH     = self.anchorH
	local anchorV     = self.anchorV
	local size        = self.size
	local spacing     = self.spacing
	local cols        = self.columns
	local rows        = ceil(self.max / cols)

	local fontFace    = GetFontFile(db.fontFace)
	local fontScale   = db.fontScale
	local fontOutline = db.fontOutline

	local offset = self.GetLayoutOffset and self:GetLayoutOffset() or 0
	for i = 1, #self.buttons do
		local button = self.buttons[i]
		local j = i + offset

		local col = (j - 1) % cols
		local row = ceil(j / cols) - 1

		local x = floor(col * (spacing + size) * (anchorH == "LEFT" and 1 or -1) + 0.5)
		local y = floor(row * (spacing + (size * 1.5)) + 0.5)

		button:ClearAllPoints()
		button:SetSize(size, size)
		button:SetPoint(anchorV .. anchorH, self, anchorV .. anchorH, x, anchorV == "BOTTOM" and y or -y)
		button:SetHitRectInsets(-spacing * 0.5, -spacing * 0.5, -spacing * 0.5, -spacing * 0.5)

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

	self:SetWidth((size * cols) + (spacing * (cols - 1)))
	self:SetHeight((size * rows) + (spacing * (rows - 1)))

	self:ClearAllPoints()
	self:PostUpdateLayout()
end

------------------------------------------------------------------------

local function SortAuras(a, b)
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

local function AuraFrame_OnUpdate(self, elapsed)
	local t = (self.timeSinceLastUpdate or 0) + elapsed
	if t < 0.1 then return end
	self.timeSinceLastUpdate = t

	local maxTimeToShow = db.maxTimer
	local now = GetTime()

	for i = 1, #self.auras do
		local button = self.buttons[i]
		local remaining = button.expires - now
		if remaining <= maxTimeToShow and remaining > 0 then
			if remaining > 3600 then
				button.timer:SetFormattedText(HOUR_ONELETTER_ABBR, floor((remaining / 60) + 0.5))
			elseif remaining > 60 then
				button.timer:SetFormattedText(MINUTE_ONELETTER_ABBR, floor((remaining / 60) + 0.5))
			else
				button.timer:SetFormattedText("%d", remaining + 0.5)
			end
		else
			button.timer:SetText()
		end
	end
end

local function AuraFrame_Update(self)
	if self.updating then -- somehow happens during loading screens / end of taxi
		return --print("STOP RECURSION NOW")
	end
	self.updating = true

	--print("~~~~~~~~~~~~~~~")
	local auras = self.auras
	local buttons = self.buttons
	local ignore = self.ignoreList

	local numDisplayedAuras = 0

	for i = 1, self.max do
		local name, _, icon, count, dispelType, duration, expires, caster, _, _, spellID = UnitAura(self.unit, i, self.filter)
		if not icon or icon == "" then
			break
		end

		if not ignore[name] then
			numDisplayedAuras = numDisplayedAuras + 1

			local t = auras[numDisplayedAuras] or newTable()

			t.caster     = caster
			t.count      = count and count > 0 and count or 1
			t.duration   = duration or 0
			t.expires    = expires or 0
			t.icon       = icon
			t.index      = i
			t.dispelType = dispelType
			t.name       = name
			t.spellID    = spellID

			auras[numDisplayedAuras] = t
			--print("+++", numDisplayedAuras, name, count, duration)
		end
	end

	for i = numDisplayedAuras + 1, #auras do
		auras[i] = remTable(auras[i])
		--print("——", i, auras[i])
	end

	sort(auras, SortAuras)
	--print("===", #auras, "<=>", numDisplayedAuras, #auras == numDisplayedAuras and "|cff22ff22OK" or "|cffff4444MISMATCH!")

	for i = 1, #auras do
		local aura = auras[i]
		local button = buttons[i]
		--print(">>>", i, aura.name, aura.count, aura.duration)

		button.caster     = aura.caster
		button.dispelType = aura.dispelType
		button.expires    = aura.expires
		button.index      = aura.index
		button.name       = aura.name

		button.icon:SetTexture(aura.icon)
		button.count:SetText(aura.count > 1 and aura.count or nil)

		if button:IsMouseOver() then
			local OnLeave = button:GetScript("OnLeave")
			if OnLeave then
				OnLeave(button)
			end
			local OnEnter = button:GetScript("OnEnter")
			if OnEnter then
				OnEnter(button)
			end
		end

		if self.PostUpdateAuraButton then
			self:PostUpdateAuraButton(button, true)
		end

		button:Show()
	end

	if #buttons > #auras then
		for i = #auras + 1, #buttons do
			local button = buttons[i]

			local OnLeave = button:GetScript("OnLeave")
			if OnLeave and button:IsMouseOver() then
				OnLeave(button)
			end

			button:Hide()
			button.icon:SetTexture("")
			button.count:SetText("")

			button.caster     = nil
			button.dispelType = nil
			button.expires    = nil
			button.index      = nil
			button.name       = nil

			if self.PostUpdateAuraButton then
				self:PostUpdateAuraButton(button, false)
			end
		end
	end
	
	self:SetScript("OnUpdate", numDisplayedAuras > 0 and AuraFrame_OnUpdate or nil)

	self.updating = nil
end

local function AuraFrame_OnEvent(self, event, unit)
	if event == "UNIT_AURA" then
		self:Update()
	elseif event == "UNIT_ENTERED_VEHICLE" then
		if UnitHasVehicleUI("player") then
			self.unit = "vehicle"
		end
		self:Update()
	elseif event == "UNIT_EXITED_VEHICLE" then
		self.unit = "player"
		self:Update()
	elseif event == "PLAYER_ENTERING_WORLD" then
		if UnitHasVehicleUI("player") then
			self.unit = "vehicle"
		else
			self.unit = "player"
		end
	elseif event == "PET_BATTLE_OPENING_START" then
		self:Hide()
	elseif event == "PET_BATTLE_CLOSE" then
		self:Show()
		self:Update()
	end
end

local function AuraFrame_Initialize(self)
	if self.loaded then return end

	self:SetScript("OnEvent", AuraFrame_OnEvent)

	self:RegisterUnitEvent("UNIT_AURA", "player", "vehicle")
	self:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	self:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PET_BATTLE_OPENING_START")
	self:RegisterEvent("PET_BATTLE_CLOSE")

	if self.PostInitialize then
		self:PostInitialize()
	end

	AuraFrame_OnEvent(self, "PLAYER_ENTERING_WORLD")
	self:ApplySettings()
	self.loaded = true

	self:Update()
end

function ns.CreateAuraFrame(name)
	local f = CreateFrame("Frame", name, UIParent)
	f.Initialize   = AuraFrame_Initialize
	f.UpdateLayout = AuraFrame_UpdateLayout
	f.Update       = AuraFrame_Update

	f.auras = {}

	f.buttons = setmetatable({}, { __index = function(t, i)
		local button = CreateAuraButton(f)
		t[i] = button
		f:UpdateLayout()
		return button
	end })

	f:SetScript("OnEvent", AuraFrame_OnEvent)
	tinsert(ns.auraFrames, f)
	return f
end
