--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
	https://github.com/Phanx/PhanxBuffs
----------------------------------------------------------------------]]

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

	showFakeBuffs = true,
	showBuffSources = true,

	minimapIcon = {},
}

local defaultIgnore = {
	buffs = {},
	debuffs = {},
}

------------------------------------------------------------------------

local ADDON_NAME, ns = ...

local L = setmetatable(ns.L, { __index = function(t, k)
	if not k then return "" end
	local v = tostring(k)
	t[k] = v
	return v
end })

L["%d minutes remaining"] = SPELL_TIME_REMAINING_MIN -- "%d |4minute:minutes; remaining"
L["%d seconds remaining"] = SPELL_TIME_REMAINING_SEC -- "%d |4second:seconds; remaining"

------------------------------------------------------------------------

local Media = LibStub("LibSharedMedia-3.0")

------------------------------------------------------------------------

local function GetFontFile(name)
	return Media:Fetch("font", name)
end

local function SetButtonFonts(parent, face, outline)
	if not face then face = db.fontFace end
	if not outline then outline = db.fontOutline end

	local file = Media:Fetch("font", face)
	local scale = db.fontScale

	for i = 1, #parent.buttons do
		local button = parent.buttons[i]
		button.count:SetFont(file, 18 * scale, outline)
		button.timer:SetFont(file, 14 * scale, outline)
		if button.symbol then
			button.symbol:SetFont(file, 16 * scale, outline)
		end
	end
end

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

		self.broker = LibStub("LibDataBroker-1.1"):NewDataObject(ADDON_NAME, {
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

		PhanxBuffsIgnoreDB = initDB(PhanxBuffsIgnoreDB, defaultIgnore)

		local function MediaCallback(callbackName, mediaType, mediaName)
			if mediaType == "font" then
				SetButtonFonts(PhanxBuffFrame)
				SetButtonFonts(PhanxDebuffFrame)
				SetButtonFonts(PhanxTempEnchantFrame)
			end
		end
		Media.RegisterCallback(self, "LibSharedMedia_Registered", MediaCallback)
		Media.RegisterCallback(self, "LibSharedMedia_SetGlobal", MediaCallback)

		BuffFrame:Hide()
		TemporaryEnchantFrame:Hide()
		BuffFrame:UnregisterAllEvents()

		PhanxBuffFrame:Load()
		PhanxDebuffFrame:Load()
		PhanxTempEnchantFrame:Load()

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

cancelButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
cancelButton:SetAttribute("unit", "player")
cancelButton:SetAttribute("type2", "macro")

cancelButton.overlay = cancelButton:CreateTexture(nil, "BACKGROUND")
cancelButton.overlay:SetAllPoints(true)
cancelButton.overlay:SetTexture(1, 0, 0, 0.5)
cancelButton.overlay:Hide()

cancelButton.icon = cancelButton:CreateTexture(nil, "BACKGROUND")
cancelButton.icon:SetAllPoints(true)

function cancelButton:SetMacro(button, macro)
	if InCombatLockdown() then return end

	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 2)
	self:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
	self:SetFrameLevel(100)

	self.owner = button
	self:SetAttribute("macrotext2", macro .. "\n/run if not InCombatLockdown() then PhanxBuffsCancelButton:Hide() end")

	self:Show()
end

cancelButton:SetScript("OnHide", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", UIParent, 0, 0)
	if self.owner and self.owner:IsMouseOver() then
		self.owner:GetScript("OnEnter")(self.owner)
	else
		self.owner:GetScript("OnLeave")(self.owner)
	end
	self.owner = nil
end)

cancelButton:SetScript("OnEnter", function(self)
	return self.owner:GetScript("OnEnter")(self.owner)
end)

cancelButton:SetScript("OnLeave", function(self)
	self:Hide()
end)

cancelButton:RegisterEvent("PLAYER_REGEN_DISABLED")
cancelButton:SetScript("OnEvent", function(self)
	if not InCombatLockdown() then
		self:Hide()
	end
end)

------------------------------------------------------------------------

function ns.CreateAuraIcon(parent)
	local button = CreateFrame("Button", nil, parent)
	button:EnableMouse(true)
	button:RegisterForClicks("RightButtonUp")

	button.icon = button:CreateTexture(nil, "BACKGROUND")
	button.icon:SetAllPoints(button)

	button.count = button:CreateFontString(nil, "OVERLAY")
	button.count:SetPoint("CENTER", button, "TOP")
	button.count:SetShadowOffset(1, -1)

	button.timer = button:CreateFontString(nil, "OVERLAY")
	button.timer:SetPoint("TOP", button, "BOTTOM")
	button.timer:SetShadowOffset(1, -1)

	if PhanxBorder and (db.noMasque or not LibStub("Masque", true)) then
		PhanxBorder.AddBorder(button)
		button.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end

	return button
end


------------------------------------------------------------------------

do
	local dragBackdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"
	}

	local function OnDragStart(self)
		self:StartMoving()
	end

	local function OnDragStop(self)
		self:StopMovingOrSizing()

		local w, h, x, y = UIParent:GetWidth(), UIParent:GetHeight(), self:GetCenter()
		w, h, x, y = floor(w + 0.5), floor(h + 0.5), floor(x + 0.5), floor(y + 0.5)
		local hhalf, vhalf = (x > w / 2) and "RIGHT" or "LEFT", (y > h / 2) and "TOP" or "BOTTOM"
		local dx = hhalf == "RIGHT" and floor(self:GetRight() + 0.5) - w or floor(self:GetLeft() + 0.5)
		local dy = vhalf == "TOP" and floor(self:GetTop() + 0.5) - h or floor(self:GetBottom() + 0.5)

		if self:GetName() == "PhanxDebuffFrame" then
			db.debuffPoint, db.debuffX, db.debuffY = vhalf..hhalf, dx, dy
		else
			db.buffPoint, db.buffX, db.buffY = vhalf..hhalf, dx, dy
		end

		self:ClearAllPoints()
		self:SetPoint(vhalf..hhalf, UIParent, dx, dy)
	end

	local isLocked = true

	function ns.ToggleFrameLocks(lock)
		if lock == nil then
			lock = not isLocked
		end

		PhanxBuffFrame:UpdateLayout()
		PhanxDebuffFrame:UpdateLayout()

		if lock then
			PhanxBuffFrame:SetBackdrop(nil)
			PhanxBuffFrame:SetMovable(false)
			PhanxBuffFrame:SetScript("OnDragStart", nil)
			PhanxBuffFrame:SetScript("OnDragStop", nil)
			PhanxBuffFrame:EnableMouse(false)
			PhanxBuffFrame:RegisterForDrag(nil)

			PhanxDebuffFrame:SetBackdrop(nil)
			PhanxDebuffFrame:SetMovable(false)
			PhanxDebuffFrame:SetScript("OnDragStart", nil)
			PhanxDebuffFrame:SetScript("OnDragStop", nil)
			PhanxDebuffFrame:EnableMouse(false)
			PhanxDebuffFrame:RegisterForDrag(nil)

			isLocked = true
		else
			PhanxBuffFrame:SetBackdrop(dragBackdrop)
			PhanxBuffFrame:SetBackdropColor(1, 1, 1, 1)
			PhanxBuffFrame:SetClampedToScreen(true)
			PhanxBuffFrame:SetMovable(true)
			PhanxBuffFrame:SetScript("OnDragStart", OnDragStart)
			PhanxBuffFrame:SetScript("OnDragStop", OnDragStop)
			PhanxBuffFrame:EnableMouse(true)
			PhanxBuffFrame:RegisterForDrag("LeftButton")

			PhanxDebuffFrame:SetBackdrop(dragBackdrop)
			PhanxDebuffFrame:SetBackdropColor(1, 1, 1, 1)
			PhanxDebuffFrame:SetClampedToScreen(true)
			PhanxDebuffFrame:SetMovable(true)
			PhanxDebuffFrame:SetScript("OnDragStart", OnDragStart)
			PhanxDebuffFrame:SetScript("OnDragStop", OnDragStop)
			PhanxDebuffFrame:EnableMouse(true)
			PhanxDebuffFrame:RegisterForDrag("LeftButton")

			isLocked = false
		end
	end
end

------------------------------------------------------------------------

local optionsPanel = LibStub("PhanxConfig-OptionsPanel").CreateOptionsPanel(ADDON_NAME, nil, function(self)
	local title, notes = self:CreateHeader(ADDON_NAME, L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."])

	---------------------------------------------------------------------

	local buffSize = self:CreateSlider(L["Buff Size"], L["Adjust the size of each buff icon."], 10, 80, 2)
	buffSize:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -4, -8)
	buffSize:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, -8)

	function buffSize:OnValueChanged(value)
		db.buffSize = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	---------------------------------------------------------------------

	local buffSpacing = self:CreateSlider(L["Buff Spacing"], L["Adjust the space between buff icons."], 0, 20, 1)
	buffSpacing:SetPoint("TOPLEFT", buffSize, "BOTTOMLEFT", 0, -12)
	buffSpacing:SetPoint("TOPRIGHT", buffSize, "BOTTOMRIGHT", 0, -12)

	function buffSpacing:OnValueChanged(value)
		db.buffSpacing = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	---------------------------------------------------------------------

	local buffColumns = self:CreateSlider(L["Buff Columns"], L["Adjust the number of buff icons to show on each row."], 1, 40, 1)
	buffColumns:SetPoint("TOPLEFT", buffSpacing, "BOTTOMLEFT", 0, -12)
	buffColumns:SetPoint("TOPRIGHT", buffSpacing, "BOTTOMRIGHT", 0, -12)

	function buffColumns:OnValueChanged(value)
		db.buffColumns = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	---------------------------------------------------------------------

	local buffAnchorV = self:CreateDropdown(L["Buff Anchor"], L["Choose whether the buff icons grow from top to bottom, or bottom to top."])
	buffAnchorV:SetPoint("TOPLEFT", buffColumns, "BOTTOMLEFT", 0, -14)
	buffAnchorV:SetPoint("TOPRIGHT", buffColumns, "BOTTOM", 0, -14)

	buffAnchorV:SetList({
		{ value = "TOP",    text = L["Top"]    },
		{ value = "BOTTOM", text = L["Bottom"] },
	})

	function buffAnchorV:OnValueChanged(value, text)
		db.buffAnchorV = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	---------------------------------------------------------------------

	local buffAnchorH = self:CreateDropdown(L["Buff Anchor"], L["Choose whether the buff icons grow from left to right, or right to left."])
	buffAnchorH:SetPoint("TOPLEFT", buffColumns, "BOTTOM", 0, -14)
	buffAnchorH:SetPoint("TOPRIGHT", buffColumns, "BOTTOMRIGHT", 0, -14)

	buffAnchorH:SetList({
		{ value = "LEFT",  text = L["Left"]  },
		{ value = "RIGHT", text = L["Right"] },
	})

	function buffAnchorH:OnValueChanged(value, text)
		db.buffAnchorH = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	buffAnchorH.labelText:Hide()
	buffAnchorV.labelText:SetPoint("TOPRIGHT", buffAnchorH, -5, 0)

	---------------------------------------------------------------------

	local debuffSize = self:CreateSlider(L["Debuff Size"], L["Adjust the size of each debuff icon."], 10, 80, 2)
	debuffSize:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -8)
	debuffSize:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)

	function debuffSize:OnValueChanged(value)
		db.debuffSize = value
		PhanxDebuffFrame:UpdateLayout()
	end

	---------------------------------------------------------------------

	local debuffSpacing = self:CreateSlider(L["Debuff Spacing"], L["Adjust the space between debuff icons."], 0, 20, 1)
	debuffSpacing:SetPoint("TOPLEFT", debuffSize, "BOTTOMLEFT", 0, -12)
	debuffSpacing:SetPoint("TOPRIGHT", debuffSize, "BOTTOMRIGHT", 0, -12)

	function debuffSpacing:OnValueChanged(value)
		db.debuffSpacing = value
		PhanxDebuffFrame:UpdateLayout()
	end

	---------------------------------------------------------------------

	local debuffColumns = self:CreateSlider(L["Debuff Columns"], L["Adjust the number of debuff icons to show on each row."], 1, 40, 1)
	debuffColumns:SetPoint("TOPLEFT", debuffSpacing, "BOTTOMLEFT", 0, -12)
	debuffColumns:SetPoint("TOPRIGHT", debuffSpacing, "BOTTOMRIGHT", 0, -12)

	function debuffColumns:OnValueChanged(value)
		db.debuffColumns = value
		PhanxDebuffFrame:UpdateLayout()
	end

	---------------------------------------------------------------------

	local debuffAnchorV = self:CreateDropdown(L["Debuff Anchor"], L["Choose whether the debuff icons grow from top to bottom, or bottom to top."])
	debuffAnchorV:SetPoint("TOPLEFT", debuffColumns, "BOTTOMLEFT", 0, -14)
	debuffAnchorV:SetPoint("TOPRIGHT", debuffColumns, "BOTTOM", 0, -14)

	debuffAnchorV:SetList({
		{ value = "TOP",    text = L["Top"]    },
		{ value = "BOTTOM", text = L["Bottom"] },
	})

	function debuffAnchorV:OnValueChanged(value, text)
		db.debuffAnchorV = value
		PhanxDebuffFrame:UpdateLayout()
	end

	---------------------------------------------------------------------

	local debuffAnchorH = self:CreateDropdown(L["Debuff Anchor"], L["Choose whether the debuff icons grow from left to right, or right to left."])
	debuffAnchorH:SetPoint("TOPLEFT", debuffColumns, "BOTTOM", 0, -14)
	debuffAnchorH:SetPoint("TOPRIGHT", debuffColumns, "BOTTOMRIGHT", 0, -14)

	debuffAnchorH:SetList({
		{ value = "LEFT",  text = L["Left"]  },
		{ value = "RIGHT", text = L["Right"] },
	})

	function debuffAnchorH:OnValueChanged(value, text)
		db.debuffAnchorH = value
		PhanxDebuffFrame:UpdateLayout()
	end

	debuffAnchorH.labelText:Hide()
	debuffAnchorV.labelText:SetPoint("TOPRIGHT", debuffAnchorH, -5, 0)

	---------------------------------------------------------------------

	local fontFace = self:CreateDropdown(L["Typeface"], L["Set the typeface for the stack count and timer text."], Media:List("font"))
	fontFace:SetPoint("TOPLEFT", buffAnchorV, "BOTTOMLEFT", 0, -32)
	fontFace:SetPoint("TOPRIGHT", buffAnchorH, "BOTTOMRIGHT", 0, -32)

	function fontFace:OnValueChanged(value)
		local _, height, flags = self.valueText:GetFont()
		self.valueText:SetFont(Media:Fetch("font", value), height, flags)

		db.fontFace = value
		SetButtonFonts(PhanxBuffFrame, value)
		SetButtonFonts(PhanxDebuffFrame, value)
		SetButtonFonts(PhanxTempEnchantFrame, value)
	end

	function fontFace:OnListButtonChanged(button, value, selected)
		if button:IsShown() then
			local buttonText = button:GetFontString()
			local _, height, flags = buttonText:GetFont()
			buttonText:SetFont(Media:Fetch("font", value), height, flags)
		end
	end

	fontFace.__SetValue = fontFace.SetValue
	function fontFace:SetValue(value)
		local _, height, flags = self.valueText:GetFont()
		self.valueText:SetFont(Media:Fetch("font", value), height, flags)
		self:__SetValue(value)
	end

	---------------------------------------------------------------------

	local fontOutline = self:CreateDropdown(L["Text Outline"], L["Set the outline weight for the stack count and timer text."])
	fontOutline:SetPoint("TOPLEFT", fontFace, "BOTTOMLEFT", 0, -12)
	fontOutline:SetPoint("TOPRIGHT", fontFace, "BOTTOMRIGHT", 0, -12)

	fontOutline:SetList({
		{ value = "NONE", text = L["None"] },
		{ value = "OUTLINE", text = L["Thin"] },
		{ value = "THICKOUTLINE", text = L["Thick"] },
	})

	function fontOutline:OnValueChanged(value, text)
		db.fontOutline = value
		SetButtonFonts(PhanxBuffFrame, nil, value)
		SetButtonFonts(PhanxDebuffFrame, nil, value)
		SetButtonFonts(PhanxTempEnchantFrame, nil, value)
	end

	---------------------------------------------------------------------

	local fontScale = self:CreateSlider(L["Text Size"], L["Adjust the size of the stack count and timer text."], 0.5, 1.5, 0.05, true)
	fontScale:SetPoint("TOPLEFT", fontOutline, "BOTTOMLEFT", 0, -12)
	fontScale:SetPoint("TOPRIGHT", fontOutline, "BOTTOMRIGHT", 0, -12)

	function fontScale:OnValueChanged(value)
		db.fontScale = value
		PhanxBuffFrame:UpdateLayout()
		PhanxDebuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	---------------------------------------------------------------------

	local maxTimer = self:CreateSlider(L["Max Timer Duration"], L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."], 0, 600, 30)
	maxTimer:SetPoint("TOPLEFT", fontScale, "BOTTOMLEFT", 0, -32)
	maxTimer:SetPoint("TOPRIGHT", fontScale, "BOTTOMRIGHT", 0, -32)

	function maxTimer:OnValueChanged(value)
		db.maxTimer = value
		PhanxBuffFrame:UpdateLayout()
		PhanxDebuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	---------------------------------------------------------------------

	local consolidateBuffs = self:CreateCheckbox(CONSOLIDATE_BUFFS_TEXT, OPTION_TOOLTIP_CONSOLIDATE_BUFFS)
	consolidateBuffs:SetPoint("TOPLEFT", debuffAnchorV, "BOTTOMLEFT", 0, -44)

	function consolidateBuffs:OnValueChanged(checked)
		SetCVar("consolidateBuffs", checked and 1 or 0)
		InterfaceOptionsBuffsPanelConsolidateBuffs:SetChecked(checked)
		BlizzardOptionsPanel_CheckButton_SetNewValue(InterfaceOptionsBuffsPanelConsolidateBuffs)
		-- no need to manually update PhanxBuffFrame, SetCVar hook will catch it
	end

	---------------------------------------------------------------------

	local showFakeBuffs = self:CreateCheckbox(L["Show Stance Icons"], L["Show fake buff icons for warrior stances and paladin seals."])
	showFakeBuffs:SetPoint("TOPLEFT", consolidateBuffs, "BOTTOMLEFT", 0, -8)

	function showFakeBuffs:OnValueChanged(checked)
		db.showFakeBuffs = checked
		PhanxBuffFrame:Update()
	end

	---------------------------------------------------------------------

	local showBuffSources = self:CreateCheckbox(L["Show Buff Sources"], L["Show the name of the party or raid member who cast a buff on you in its tooltip."])
	showBuffSources:SetPoint("TOPLEFT", showFakeBuffs, "BOTTOMLEFT", 0, -8)

	function showBuffSources:OnValueChanged(checked)
		db.showBuffSources = checked
	end

	---------------------------------------------------------------------

	local lockFrames = self:CreateCheckbox(L["Lock Frames"], L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."])
	lockFrames:SetPoint("TOPLEFT", showBuffSources, "BOTTOMLEFT", 0, -8)
	lockFrames:SetChecked(true)

	function lockFrames:OnValueChanged(checked)
		ns.ToggleFrameLocks(checked)
	end

	---------------------------------------------------------------------

	self.refresh = function()
		buffSize:SetValue(db.buffSize)
		buffSpacing:SetValue(db.buffSpacing)
		buffColumns:SetValue(db.buffColumns)
		buffAnchorH:SetValue(db.buffAnchorH)
		buffAnchorV:SetValue(db.buffAnchorV)

		debuffSize:SetValue(db.debuffSize)
		debuffSpacing:SetValue(db.debuffSpacing)
		debuffColumns:SetValue(db.debuffColumns)
		debuffAnchorH:SetValue(db.debuffAnchorH)
		debuffAnchorV:SetValue(db.debuffAnchorV)

		fontFace:SetValue(db.fontFace)
		fontOutline:SetValue(db.fontOutline)
		fontScale:SetValue(db.fontScale)
		maxTimer:SetValue(db.maxTimer)

		consolidateBuffs:SetChecked(GetCVarBool("consolidateBuffs"))
		showFakeBuffs:SetChecked(db.showFakeBuffs)
		showBuffSources:SetChecked(db.showBuffSources)
	end
end)

------------------------------------------------------------------------

local aboutPanel = LibStub("LibAboutPanel").new("PhanxBuffs", "PhanxBuffs")

------------------------------------------------------------------------

SLASH_PHANXBUFFS1 = "/pbuff"
SlashCmdList.PHANXBUFFS = function(input)
	if not input then input = "" end

	local cmd, arg = input:match("^(%S+)%s*(.*)$")
	cmd = cmd and cmd:lower()

	if arg and arg ~= "" then
		if cmd == "buff" or cmd == L["buff"] then
			local ignoring = not PhanxBuffsIgnoreDB.buffs[arg] and true or nil
			PhanxBuffsIgnoreDB.buffs[arg] = ignoring
			print("|cffffcc00PhanxBuffs:|r", format(ignoring and L["Now ignoring buff: %s."] or L["No longer ignoring buff: %s."], arg))
			return PhanxBuffFrame:Update()
		elseif cmd == "debuff" or cmd == L["debuff"] then
			local ignoring = not PhanxBuffsIgnoreDB.debuffs[arg] and true or nil
			PhanxBuffsIgnoreDB.debuffs[arg] = ignoring
			print("|cffffcc00PhanxBuffs:|r", format(ignoring and L["Now ignoring debuff: %s."] or L["No longer ignoring debuff: %s."], arg))
			return PhanxDebuffFrame:Update()
		end
		return
	elseif cmd == "buff" or cmd == L["buff"] then
		local t = {}
		for buff in pairs(PhanxBuffsIgnoreDB.buffs) do
			t[#t + 1] = buff
		end
		if #t == 0 then
			print("|cffffcc00PhanxBuffs:|r", L["No buffs are being ignored."])
		else
			sort(t)
			print("|cffffcc00PhanxBuffs:|r", format(L["%d |4buff:buffs; |4is:are; being ignored:"], #t))
			for i = 1, #t do
				print("   ", t[i])
			end
		end
		return
	elseif cmd == "debuff" or cmd == L["debuff"] then
		local t = {}
		for debuff in pairs(PhanxBuffsIgnoreDB.debuffs) do
			t[#t + 1] = debuff
		end
		if #t == 0 then
			print("|cffffcc00PhanxBuffs:|r", L["No debuffs are being ignored."])
		else
			sort(t)
			print("|cffffcc00PhanxBuffs:|r", format(L["%d |4debuff:debuffs; |4is:are; being ignored:"], #t))
			for i = 1, #t do
				print("   ", t[i])
			end
		end
		return
	elseif command == "lock" or command == "unlock" or command == L["lock"] or command == L["unlock"] then
		ns.ToggleFrameLocks()
	else
		InterfaceOptionsFrame_OpenToCategory(optionsPanel)
		InterfaceOptionsFrame_OpenToCategory(optionsPanel)
	end
end

------------------------------------------------------------------------

ns.GetFontFile = GetFontFile
ns.SetButtonSize = SetButtonSize
ns.optionsPanel = optionsPanel
ns.aboutPanel = aboutPanel