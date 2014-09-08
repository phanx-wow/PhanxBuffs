--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
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
	showTempEnchantSources = true,
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

	local file = GetFontFile(face)
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
cancelButton:SetAttribute("*type1", "macro")
cancelButton:SetAttribute("*macrotext1", "/run if not InCombatLockdown() then PhanxBuffsCancelButton:Hide() end")
cancelButton:SetAttribute("*type2", "macro")

cancelButton.overlay = cancelButton:CreateTexture(nil, "BACKGROUND")
cancelButton.overlay:SetAllPoints(true)
cancelButton.overlay:SetTexture(1, 0, 0, 0.5)

cancelButton.icon = cancelButton:CreateTexture(nil, "BACKGROUND")
cancelButton.icon:SetAllPoints(true)
cancelButton.icon:Hide()

function cancelButton:SetMacro(button, icon, macro)
	if db.noCancel or InCombatLockdown() then return end

	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 2)
	self:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
	self:SetFrameLevel(100)

	self.icon:SetTexture(icon)

	self:SetAttribute("*macrotext2", macro .. "\n/run if not InCombatLockdown() then PhanxBuffsCancelButton:Hide() end")

	self:Show()
end

cancelButton:SetScript("OnHide", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
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

	if PhanxBorder and db.noMasque then
		PhanxBorder.AddBorder(button)
		button.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end

	return button
end


------------------------------------------------------------------------

local optionsPanel = LibStub("PhanxConfig-OptionsPanel").CreateOptionsPanel(ADDON_NAME, nil, function(self)
	local anchorsH = {
		["LEFT"] = L["Left"],
		["RIGHT"] = L["Right"],
	}
	local anchorsV = {
		["TOP"] = L["Top"],
		["BOTTOM"] = L["Bottom"],
	}
	local outlines = {
		["NONE"] = L["None"],
		["OUTLINE"] = L["Thin"],
		["THICKOUTLINE"] = L["Thick"],
	}

	--------------------------------------------------------------------

	local title, notes = self:CreateHeader(ADDON_NAME, L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."])

	--------------------------------------------------------------------

	local buffSize = self:CreateSlider(L["Buff Size"], L["Adjust the size of each buff icon."], 10, 80, 2)
	buffSize:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -4, -8)
	buffSize:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, -8)

	function buffSize:Callback(value)
		db.buffSize = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local buffSpacing = self:CreateSlider(L["Buff Spacing"], L["Adjust the space between buff icons."], 0, 20, 1)
	buffSpacing:SetPoint("TOPLEFT", buffSize, "BOTTOMLEFT", 0, -12)
	buffSpacing:SetPoint("TOPRIGHT", buffSize, "BOTTOMRIGHT", 0, -12)

	function buffSpacing:Callback(value)
		db.buffSpacing = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local buffColumns = self:CreateSlider(L["Buff Columns"], L["Adjust the number of buff icons to show on each row."], 1, 40, 1)
	buffColumns:SetPoint("TOPLEFT", buffSpacing, "BOTTOMLEFT", 0, -12)
	buffColumns:SetPoint("TOPRIGHT", buffSpacing, "BOTTOMRIGHT", 0, -12)

	function buffColumns:Callback(value)
		db.buffColumns = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local buffAnchorV
	do
		local function OnClick(self)
			local value = self.value
			db.buffAnchorV = value
			buffAnchorV:SetValue(value, anchorsV[value])
			PhanxBuffFrame:UpdateLayout()
			PhanxTempEnchantFrame:UpdateLayout()
		end

		buffAnchorV = self:CreateDropdown(L["Buff Anchor"], L["Choose whether the buff icons grow from top to bottom, or bottom to top."], function()
			local info = UIDropDownMenu_CreateInfo()
			local selected = db.buffAnchorV

			info.text = L["Top"]
			info.value = "TOP"
			info.func = OnClick
			info.checked = "TOP" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Bottom"]
			info.value = "BOTTOM"
			info.func = OnClick
			info.checked = "BOTTOM" == selected
			UIDropDownMenu_AddButton(info)
		end)
		buffAnchorV:SetPoint("TOPLEFT", buffColumns, "BOTTOMLEFT", 0, -14)
		buffAnchorV:SetPoint("TOPRIGHT", buffColumns, "BOTTOM", 0, -14)
	end

	--------------------------------------------------------------------

	local buffAnchorH
	do
		local function OnClick(self)
			local value = self.value
			db.buffAnchorH = value
			buffAnchorH:SetValue(value, anchorsH[value])
			PhanxBuffFrame:UpdateLayout()
			PhanxTempEnchantFrame:UpdateLayout()
		end

		buffAnchorH = self:CreateDropdown(L["Buff Anchor"], L["Choose whether the buff icons grow from left to right, or right to left."], function()
			local info = UIDropDownMenu_CreateInfo()
			local selected = db.buffAnchorH

			info.text = L["Right"]
			info.value = "RIGHT"
			info.func = OnClick
			info.checked = "RIGHT" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Left"]
			info.value = "LEFT"
			info.func = OnClick
			info.checked = "LEFT" == selected
			UIDropDownMenu_AddButton(info)
		end)
		buffAnchorH:SetPoint("TOPLEFT", buffColumns, "BOTTOM", 0, -14)
		buffAnchorH:SetPoint("TOPRIGHT", buffColumns, "BOTTOMRIGHT", 0, -14)

		buffAnchorH.labelText:Hide()
		buffAnchorV.labelText:SetPoint("TOPRIGHT", buffAnchorH, -5, 0)
	end

	--------------------------------------------------------------------

	local debuffSize = self:CreateSlider(L["Debuff Size"], L["Adjust the size of each debuff icon."], 10, 80, 2)
	debuffSize:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -8)
	debuffSize:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)

	function debuffSize:Callback(value)
		db.debuffSize = value
		PhanxDebuffFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local debuffSpacing = self:CreateSlider(L["Debuff Spacing"], L["Adjust the space between debuff icons."], 0, 20, 1)
	debuffSpacing:SetPoint("TOPLEFT", debuffSize, "BOTTOMLEFT", 0, -12)
	debuffSpacing:SetPoint("TOPRIGHT", debuffSize, "BOTTOMRIGHT", 0, -12)

	function debuffSpacing:Callback(value)
		db.debuffSpacing = value
		PhanxDebuffFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local debuffColumns = self:CreateSlider(L["Debuff Columns"], L["Adjust the number of debuff icons to show on each row."], 1, 40, 1)
	debuffColumns:SetPoint("TOPLEFT", debuffSpacing, "BOTTOMLEFT", 0, -12)
	debuffColumns:SetPoint("TOPRIGHT", debuffSpacing, "BOTTOMRIGHT", 0, -12)

	function debuffColumns:Callback(value)
		db.debuffColumns = value
		PhanxDebuffFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local debuffAnchorV = self:CreateDropdown(L["Debuff Anchor"], L["Choose whether the debuff icons grow from top to bottom, or bottom to top."])
	debuffAnchorV:SetPoint("TOPLEFT", debuffColumns, "BOTTOMLEFT", 0, -14)
	debuffAnchorV:SetPoint("TOPRIGHT", debuffColumns, "BOTTOM", 0, -14)

	do
		local function OnClick(self)
			local value = self.value
			db.debuffAnchorV = value
			debuffAnchorV:SetValue(value, anchorsV[value])
			PhanxDebuffFrame:UpdateLayout()
		end

		function debuffAnchorV:Initialize(dropdown, level)
			local info = UIDropDownMenu_CreateInfo()
			local selected = db.debuffAnchorV

			info.text = L["Top"]
			info.value = "TOP"
			info.func = OnClick
			info.checked = "TOP" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Bottom"]
			info.value = "BOTTOM"
			info.func = OnClick
			info.checked = "BOTTOM" == selected
			UIDropDownMenu_AddButton(info)
		end
	end

	--------------------------------------------------------------------

	local debuffAnchorH = self:CreateDropdown(L["Debuff Anchor"], L["Choose whether the debuff icons grow from left to right, or right to left."])
	debuffAnchorH:SetPoint("TOPLEFT", debuffColumns, "BOTTOM", 0, -14)
	debuffAnchorH:SetPoint("TOPRIGHT", debuffColumns, "BOTTOMRIGHT", 0, -14)

	debuffAnchorH.labelText:Hide()
	debuffAnchorV.labelText:SetPoint("TOPRIGHT", debuffAnchorH, -5, 0)

	do
		local function OnClick(self)
			local value = self.value
			db.debuffAnchorH = value
			debuffAnchorH:SetValue(value, anchorsH[value])
			PhanxDebuffFrame:UpdateLayout()
		end

		function debuffAnchorH:Initialize(dropdown, level)
			local info = UIDropDownMenu_CreateInfo()
			local selected = db.debuffAnchorH

			info.text = L["Right"]
			info.value = "RIGHT"
			info.func = OnClick
			info.checked = "RIGHT" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Left"]
			info.value = "LEFT"
			info.func = OnClick
			info.checked = "LEFT" == selected
			UIDropDownMenu_AddButton(info)
		end
	end

	--------------------------------------------------------------------

	local fontFace = self:CreateScrollingDropdown(L["Typeface"], L["Set the typeface for the stack count and timer text."], Media:List("font"))
	fontFace:SetPoint("TOPLEFT", buffAnchorV, "BOTTOMLEFT", 0, -32)
	fontFace:SetPoint("TOPRIGHT", buffAnchorH, "BOTTOMRIGHT", 0, -32)

	function fontFace:Callback(value)
		local _, height, flags = self.valueText:GetFont()
		self.valueText:SetFont(GetFontFile(value), height, flags)

		db.fontFace = value
		SetButtonFonts(PhanxBuffFrame, value)
		SetButtonFonts(PhanxDebuffFrame, value)
		SetButtonFonts(PhanxTempEnchantFrame, value)
	end

	function fontFace:ListButtonCallback(button, value, selected)
		if button:IsShown() then
			button:GetFontString():SetFont(Media:Fetch("font", value), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
		end
	end

	fontFace.__SetValue = fontFace.SetValue
	function fontFace:SetValue(value)
		local _, height, flags = self.valueText:GetFont()
		self.valueText:SetFont(GetFontFile(value), height, flags)
		self:__SetValue(value)
	end

	--------------------------------------------------------------------

	local fontOutline = self:CreateDropdown(L["Text Outline"], L["Set the outline weight for the stack count and timer text."])
	fontOutline:SetPoint("TOPLEFT", fontFace, "BOTTOMLEFT", 0, -12)
	fontOutline:SetPoint("TOPRIGHT", fontFace, "BOTTOMRIGHT", 0, -12)
	do
		local function OnClick(self)
			local value = self.value

			db.fontOutline = value

			SetButtonFonts(PhanxBuffFrame, nil, value)
			SetButtonFonts(PhanxDebuffFrame, nil, value)
			SetButtonFonts(PhanxTempEnchantFrame, nil, value)

			fontOutline:SetValue(value, outlines[value])
		end

		function fontOutline:Initialize(dropdown, level)
			local info = UIDropDownMenu_CreateInfo()
			local selected = db.fontOutline

			info.text = L["None"]
			info.value = "NONE"
			info.func = OnClick
			info.checked = "NONE" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Thin"]
			info.value = "OUTLINE"
			info.func = OnClick
			info.checked = "OUTLINE" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Thick"]
			info.value = "THICKOUTLINE"
			info.func = OnClick
			info.checked = "THICKOUTLINE" == selected
			UIDropDownMenu_AddButton(info)
		end
	end

	--------------------------------------------------------------------

	local fontScale = self:CreateSlider(L["Text Size"], L["Adjust the size of the stack count and timer text."], 0.5, 1.5, 0.05, true)
	fontScale:SetPoint("TOPLEFT", fontOutline, "BOTTOMLEFT", 0, -12)
	fontScale:SetPoint("TOPRIGHT", fontOutline, "BOTTOMRIGHT", 0, -12)

	function fontScale:Callback(value)
		db.fontScale = value
		PhanxBuffFrame:UpdateLayout()
		PhanxDebuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local maxTimer = self:CreateSlider(L["Max Timer Duration"], L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."], 0, 600, 30)
	maxTimer:SetPoint("TOPLEFT", fontScale, "BOTTOMLEFT", 0, -32)
	maxTimer:SetPoint("TOPRIGHT", fontScale, "BOTTOMRIGHT", 0, -32)

	function maxTimer:Callback(value)
		db.maxTimer = value
		PhanxBuffFrame:UpdateLayout()
		PhanxDebuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	--------------------------------------------------------------------
	
	local consolidateBuffs = self:CreateCheckbox(CONSOLIDATE_BUFFS_TEXT, OPTION_TOOLTIP_CONSOLIDATE_BUFFS)
	consolidateBuffs:SetPoint("TOPLEFT", debuffAnchorV, "BOTTOMLEFT", 0, -44)
	
	function consolidateBuffs:Callback(checked)
		SetCVar("consolidateBuffs", checked and 1 or 0)
		InterfaceOptionsBuffsPanelConsolidateBuffs:SetChecked(checked)
		BlizzardOptionsPanel_CheckButton_SetNewValue(InterfaceOptionsBuffsPanelConsolidateBuffs)
		-- no need to manually update PhanxBuffFrame, SetCVar hook will catch it
	end

	--------------------------------------------------------------------

	local showFakeBuffs = self:CreateCheckbox(L["Show stance icons"], L["Show fake buff icons for warrior stances and paladin seals."])
	showFakeBuffs:SetPoint("TOPLEFT", consolidateBuffs, "BOTTOMLEFT", 0, -8)

	function showFakeBuffs:Callback(checked)
		db.showFakeBuffs = checked
		PhanxBuffFrame:Update()
	end

	--------------------------------------------------------------------

	local showBuffSources = self:CreateCheckbox(L["Buff Sources"], L["Show the name of the party or raid member who cast a buff on you in its tooltip."])
	showBuffSources:SetPoint("TOPLEFT", showFakeBuffs, "BOTTOMLEFT", 0, -8)

	function showBuffSources:Callback(checked)
		db.showBuffSources = checked
	end

	--------------------------------------------------------------------

	local showTempEnchantSources = self:CreateCheckbox(L["Weapon Buff Sources"], L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."])
	showTempEnchantSources:SetPoint("TOPLEFT", showBuffSources, "BOTTOMLEFT", 0, -8)

	function showTempEnchantSources:Callback(checked)
		db.showTempEnchantSources = checked
		PhanxTempEnchantFrame:Update()
	end

	--------------------------------------------------------------------

	local oneClickCancel = self:CreateCheckbox(L["One-Click Cancel"], L["Cancel unprotected buffs on the first click, instead of the second. Only works out of combat, and protected buffs like shapeshift forms and weapon buffs will still require two clicks."])
	oneClickCancel:SetPoint("TOPLEFT", showTempEnchantSources, "BOTTOMLEFT", 0, -8)

	function oneClickCancel:Callback(checked)
		db.oneClickCancel = checked
		PhanxBuffFrame:Update()
	end

	--------------------------------------------------------------------

	local lockFrames = self:CreateCheckbox(L["Lock Frames"], L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."])
	lockFrames:SetPoint("TOPLEFT", oneClickCancel, "BOTTOMLEFT", 0, -8)
	lockFrames:SetChecked(true)

	do
		local dragBackdrop = {
			bgFile="Interface\\Tooltips\\UI-Tooltip-Background"
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

		function lockFrames:Callback(checked)
			if checked then
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
			end
		end
	end

	self.refresh = function()
		buffSize:SetValue(db.buffSize)
		buffSpacing:SetValue(db.buffSpacing)
		buffColumns:SetValue(db.buffColumns)
		buffAnchorH:SetValue(db.buffAnchorH, anchorsH[db.buffAnchorH])
		buffAnchorV:SetValue(db.buffAnchorV, anchorsV[db.buffAnchorV])

		debuffSize:SetValue(db.debuffSize)
		debuffSpacing:SetValue(db.debuffSpacing)
		debuffColumns:SetValue(db.debuffColumns)
		debuffAnchorH:SetValue(db.debuffAnchorH, anchorsH[db.debuffAnchorH])
		debuffAnchorV:SetValue(db.debuffAnchorV, anchorsV[db.debuffAnchorV])

		fontFace:SetValue(db.fontFace)
		fontOutline:SetValue(db.fontOutline, outlines[db.fontOutline])
		fontScale:SetValue(db.fontScale)
		maxTimer:SetValue(db.maxTimer)

		consolidateBuffs:SetChecked(GetCVarBool("consolidateBuffs"))
		showFakeBuffs:SetChecked(db.showFakeBuffs)
		showBuffSources:SetChecked(db.showBuffSources)
		showTempEnchantSources:SetChecked(db.showTempEnchantSources)
		oneClickCancel:SetChecked(db.oneClickCancel)
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
	else
		InterfaceOptionsFrame_OpenToCategory(optionsPanel)
	end
end

------------------------------------------------------------------------

ns.GetFontFile = GetFontFile
ns.SetButtonSize = SetButtonSize
ns.optionsPanel = optionsPanel
ns.aboutPanel = aboutPanel