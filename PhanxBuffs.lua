--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
----------------------------------------------------------------------]]

local db
local defaultDB = {
	buffColumns = 20,
	buffSize = 24,

	debuffColumns = 10,
	debuffSize = 48,

	iconSpacing = 3,
	maxTimer = 30,
	growthAnchor = "RIGHT",

	fontFace = "Friz Quadrata TT",
	fontOutline = "OUTLINE",
	fontScale = 1,

	showBuffSources = true,
	showTempEnchantSources = true,
}
local defaultIgnore = {
	buffs = { },
	debuffs = {
		[GetSpellInfo(64805)] = true, -- Bested Darnassus
		[GetSpellInfo(64808)] = true, -- Bested the Exodar
		[GetSpellInfo(64809)] = true, -- Bested Gnomeregan
		[GetSpellInfo(64810)] = true, -- Bested Ironforge
		[GetSpellInfo(64811)] = true, -- Bested Orgrimmar
		[GetSpellInfo(64812)] = true, -- Bested Sen'jin
		[GetSpellInfo(64813)] = true, -- Bested Silvermoon City
		[GetSpellInfo(64814)] = true, -- Bested Stormwind
		[GetSpellInfo(64815)] = true, -- Bested Thunder Bluff
		[GetSpellInfo(64816)] = true, -- Bested the Undercity
		[GetSpellInfo(69127)] = true, -- Chill of the Throne
	},
}

------------------------------------------------------------------------

local ADDON_NAME, ns = ...
if not ns.L then ns.L = { } end

local L = setmetatable(ns.L, { __index = function(t, k)
	if not k then return "" end
	local v = tostring(k)
	t[k] = v
	return v
end })

L["%d minutes remaining"] = SPELL_TIME_REMAINING_MIN -- "%d |4minute:minutes; remaining"
L["%d seconds remaining"] = SPELL_TIME_REMAINING_SEC -- "%d |4second:seconds; remaining"

if GetLocale():match("^en") then
	L["Mind-Numbing Poison"] = "Mind[%-%s]Numbing Poison"
end

------------------------------------------------------------------------

local LibSharedMedia

local fonts = { }

local defaultFonts = {
	["Arial Narrow"] = [[Fonts\ARIALN.TTF]],
	["Friz Quadrata TT"] = [[Fonts\FRIZQT__.TTF]],
	["Morpheus"] = [[Fonts\MORPHEUS.ttf]],
	["Skurri"] = [[Fonts\skurri.ttf]],
}

------------------------------------------------------------------------

local function GetFontFile(name)
	local file = LibSharedMedia and LibSharedMedia:Fetch("font", name) or defaultFonts[name]
	return file or [[Fonts\FRIZQT__.TTF]]
end

local function SetButtonFonts(parent, face, outline)
	if not face then face = db.fontFace end
	if not outline then outline = db.fontOutline end

	local file = GetFontFile(face)

	local baseSize = parent == PhanxDebuffFrame and db.debuffSize or db.buffSize
	local scale = db.fontScale

	for i, button in ipairs(parent.buttons) do
		button.count:SetFont(file, baseSize * scale * 0.7, outline)
		button.timer:SetFont(file, baseSize * scale * 0.55, outline)
		if button.symbol then
			button.symbol:SetFont(file, baseSize * scale * 0.7, outline)
		end
	end
end

------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", function(self)
	local function copyTable(src, dst)
		if type(src) ~= "table" then return dst or { } end
		if type(dst) ~= "table" then dst = { } end
		for k, v in pairs(src) do
			if type(v) == "table" then
				dst[k] = copyTable(v, dst[k])
			elseif type(v) ~= type(dst[k]) then
				dst[k] = v
			end
		end
		return dst
	end

	if not PhanxBuffsDB then PhanxBuffsDB = { } end
	db = copyTable(defaultDB, PhanxBuffsDB)

	if not PhanxBuffsIgnoreDB then PhanxBuffsIgnoreDB = { } end
	copyTable(defaultIgnore, PhanxBuffsIgnoreDB)

	LibSharedMedia = LibStub("LibSharedMedia-3.0", true)

	if LibSharedMedia then
		for name, file in pairs(defaultFonts) do
			if file:match("^Interface\\AddOns") then
				LibSharedMedia:Register("font", name, file)
			end
		end
		for i, v in pairs(LibSharedMedia:List("font")) do
			table.insert(fonts, v)
		end
		table.sort(fonts)

		function self:LibSharedMedia_Registered(_, mediaType, mediaName)
			if mediaType == "font" then
				table.insert(fonts, mediaName)
				table.sort(fonts)

				SetButtonFonts(PhanxBuffFrame)
				SetButtonFonts(PhanxDebuffFrame)
				SetButtonFonts(PhanxTempEnchantFrame)
			end
		end

		LibSharedMedia.RegisterCallback(self, "LibSharedMedia_Registered", "LibSharedMedia_Registered")

		function self:LibSharedMedia_SetGlobal(_, mediaType)
			if mediaType == "font" then
				SetButtonFonts(PhanxBuffFrame)
				SetButtonFonts(PhanxDebuffFrame)
				SetButtonFonts(PhanxTempEnchantFrame)
			end
		end

		LibSharedMedia.RegisterCallback(self, "LibSharedMedia_SetGlobal",  "LibSharedMedia_SetGlobal")
	else
		for name in pairs(defaultFonts) do
			table.insert(fonts, name)
		end
		table.sort(fonts)
	end

	SetCVar("consolidateBuffs", 0)

	BuffFrame:Hide()
	TemporaryEnchantFrame:Hide()
	BuffFrame:UnregisterAllEvents()

	PhanxBuffFrame:Load()
	PhanxDebuffFrame:Load()
	PhanxTempEnchantFrame:Load()

	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
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

local optionsPanel = LibStub("PhanxConfig-OptionsPanel").CreateOptionsPanel(ADDON_NAME, nil, function(self)
	local CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
	local CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown
	local CreateScrollingDropdown = LibStub("PhanxConfig-ScrollingDropdown").CreateScrollingDropdown
	local CreateSlider = LibStub("PhanxConfig-Slider").CreateSlider

	--------------------------------------------------------------------

	local title, notes = LibStub("PhanxConfig-Header").CreateHeader(self, ADDON_NAME, L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."])

	--------------------------------------------------------------------

	local buffSize = CreateSlider(self, L["Buff Size"], 10, 60, 2)
	buffSize.desc = L["Set the size of each buff icon."]
	buffSize:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -4, -8)
	buffSize:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, -8)

	buffSize.OnValueChanged = function(self, value)
		db.buffSize = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local buffColumns = CreateSlider(self, L["Buff Columns"], 1, 40, 1)
	buffColumns.desc = L["Set the number of buff icons to show on each row."]
	buffColumns:SetPoint("TOPLEFT", buffSize, "BOTTOMLEFT", 0, -12)
	buffColumns:SetPoint("TOPRIGHT", buffSize, "BOTTOMRIGHT", 0, -12)

	buffColumns.OnValueChanged = function(self, value)
		db.buffColumns = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local debuffSize = CreateSlider(self, L["Debuff Size"], 10, 60, 2)
	debuffSize.desc = L["Set the size of each debuff icon."]
	debuffSize:SetPoint("TOPLEFT", buffColumns, "BOTTOMLEFT", 0, -12)
	debuffSize:SetPoint("TOPRIGHT", buffColumns, "BOTTOMRIGHT", 0, -12)

	debuffSize.OnValueChanged = function(self, value)
		db.debuffSize = value
		PhanxDebuffFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local debuffColumns = CreateSlider(self, L["Debuff Columns"], 1, 40, 1)
	debuffColumns.desc = L["Set the number of debuff icons to show on each row."]
	debuffColumns:SetPoint("TOPLEFT", debuffSize, "BOTTOMLEFT", 0, -12)
	debuffColumns:SetPoint("TOPRIGHT", debuffSize, "BOTTOMRIGHT", 0, -12)

	debuffColumns.OnValueChanged = function(self, value)
		db.debuffColumns = value
		PhanxDebuffFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local iconSpacing = CreateSlider(self, L["Icon Spacing"], 0, 20, 1)
	iconSpacing.desc = L["Set the space between icons."]
	iconSpacing:SetPoint("TOPLEFT", debuffColumns, "BOTTOMLEFT", 0, -12)
	iconSpacing:SetPoint("TOPRIGHT", debuffColumns, "BOTTOMRIGHT", 0, -12)

	iconSpacing.OnValueChanged = function(self, value)
		db.iconSpacing = value
		PhanxBuffFrame:UpdateLayout()
		PhanxDebuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local anchors = {
		["LEFT"] = L["Left"],
		["RIGHT"] = L["Right"],
	}

	local growthAnchor
	do
		local function OnClick(self)
			local value = self.value

			db.growthAnchor = value

			PhanxBuffFrame:UpdateLayout()
			PhanxDebuffFrame:UpdateLayout()
			PhanxTempEnchantFrame:UpdateLayout()

			growthAnchor:SetValue(self.value, self.text)
		end

		local info = { } -- UIDropDownMenu_CreateInfo()

		growthAnchor = CreateDropdown(self, L["Growth Anchor"], function()
			local selected = db.growthAnchor

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
	end
	growthAnchor.desc = L["Set the side of the screen from which buffs and debuffs grow."]
	growthAnchor:SetPoint("TOPLEFT", iconSpacing, "BOTTOMLEFT", 0, -12)
	growthAnchor:SetPoint("TOPRIGHT", iconSpacing, "BOTTOMRIGHT", 0, -12)

	--------------------------------------------------------------------

	local fontFace = CreateScrollingDropdown(self, L["Typeface"], fonts)
	fontFace.desc = L["Set the typeface for stack count and timer text."]
	fontFace:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -8)
	fontFace:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)

	do
		local _, height, flags = fontFace.valueText:GetFont()
		fontFace.valueText:SetFont(GetFontFile(db.fontFace), height, flags)

		function fontFace:OnValueChanged(value)
			db.fontFace = value

			SetButtonFonts(PhanxBuffFrame, value)
			SetButtonFonts(PhanxDebuffFrame, value)
			SetButtonFonts(PhanxTempEnchantFrame, value)

			local _, height, flags = self.valueText:GetFont()
			self.valueText:SetFont(GetFontFile(value), height, flags)
		end

		local button_OnClick = fontFace.button:GetScript("OnClick")
		fontFace.button:SetScript("OnClick", function(self)
			button_OnClick(self)
			fontFace.dropdown.list:Hide()

			local function SetButtonFonts(self)
				local buttons = fontFace.dropdown.list.buttons
				for i = 1, #buttons do
					local button = buttons[i]
					if button.value and button:IsShown() then
						button.label:SetFont(GetFontFile(button.value), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
					end
				end
			end

			local OnShow = fontFace.dropdown.list:GetScript("OnShow")
			fontFace.dropdown.list:SetScript("OnShow", function(self)
				OnShow(self)
				SetButtonFonts(self)
			end)

			local OnVerticalScroll = fontFace.dropdown.list.scrollFrame:GetScript("OnVerticalScroll")
			fontFace.dropdown.list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
				OnVerticalScroll(self, delta)
				SetButtonFonts(self)
			end)

			local SetText = fontFace.dropdown.list.text.SetText
			fontFace.dropdown.list.text.SetText = function(self, text)
				self:SetFont(GetFontFile(text), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT + 1)
				SetText(self, text)
			end

			button_OnClick(self)
			self:SetScript("OnClick", button_OnClick)
		end)
	end

	--------------------------------------------------------------------

	local outlines = {
		["NONE"] = L["None"],
		["OUTLINE"] = L["Thin"],
		["THICKOUTLINE"] = L["Thick"],
	}

	local fontOutline
	do
		local function OnClick(self)
			local value = self.value

			db.fontOutline = value

			SetButtonFonts(PhanxBuffFrame, nil, value)
			SetButtonFonts(PhanxDebuffFrame, nil, value)
			SetButtonFonts(PhanxTempEnchantFrame, nil, value)

			fontOutline:SetValue(self.value, self.text)
		end

		local info = { } -- UIDropDownMenu_CreateInfo()

		fontOutline = CreateDropdown(self, L["Text Outline"], function()
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
		end)
	end
	fontOutline.desc = L["Set the outline weight for stack count and timer text."]
	fontOutline:SetPoint("TOPLEFT", fontFace, "BOTTOMLEFT", 0, -12)
	fontOutline:SetPoint("TOPRIGHT", fontFace, "BOTTOMRIGHT", 0, -12)

	--------------------------------------------------------------------

	local fontScale = CreateSlider( self, L["Text Size"], 0.5, 1.5, 0.1, true,
		L["Adjust the size of the stack count and timer text."] )
	fontScale:SetPoint( "TOPLEFT", fontOutline, "BOTTOMLEFT", 0, -12 )
	fontScale:SetPoint( "TOPRIGHT", fontOutline, "BOTTOMRIGHT", 0, -12 )

	fontScale.OnValueChanged = function( self, value )
		db.fontScale = value

		PhanxBuffFrame:UpdateLayout()
		PhanxDebuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local maxTimer = CreateSlider(self, L["Max Timer Duration"], 0, 600, 30)
	maxTimer.desc = L["Show the timer text only when the buff or debuff's remaining duration is less than this many seconds."]
	maxTimer:SetPoint("TOPLEFT", fontScale, "BOTTOMLEFT", 0, -12)
	maxTimer:SetPoint("TOPRIGHT", fontScale, "BOTTOMRIGHT", 0, -12)

	maxTimer.OnValueChanged = function(self, value)
		db.maxTimer = value
		PhanxBuffFrame:UpdateLayout()
		PhanxDebuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()
	end

	--------------------------------------------------------------------

	local showBuffSources = CreateCheckbox(self, L["Buff Casters"])
	showBuffSources.desc = L["Show the name of the party or raid member who cast a buff on you in its tooltip."]
	showBuffSources:SetPoint("TOPLEFT", maxTimer, "BOTTOMLEFT", 0, -12)

	showBuffSources.OnClick = function(self, checked)
		db.showBuffSources = checked
	end

	--------------------------------------------------------------------

	local showTempEnchantSources = CreateCheckbox(self, L["Weapon Buff Sources"])
	showTempEnchantSources.desc = L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."]
	showTempEnchantSources:SetPoint("TOPLEFT", showBuffSources, "BOTTOMLEFT", 0, -8)

	showTempEnchantSources.OnClick = function(self, checked)
		db.showTempEnchantSources = checked
		PhanxTempEnchantFrame:Update()
	end

	--------------------------------------------------------------------

	local lockFrames = CreateCheckbox(self, L["Lock Frames"])
	lockFrames.desc = L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."]
	lockFrames:SetPoint("TOPLEFT", showTempEnchantSources, "BOTTOMLEFT", 0, -8)
	lockFrames:SetChecked(true)

	local dragBackdrop = {
		bgFile="Interface\\Tooltips\\UI-Tooltip-Background"
	}

	local function OnDragStart(self)
		self:StartMoving()
	end

	local function OnDragStop(self)
		self:StopMovingOrSizing()

		local w, h, x, y = UIParent:GetWidth(), UIParent:GetHeight(), self:GetCenter()
		local hhalf, vhalf = (x > w/2) and "RIGHT" or "LEFT", (y > h/2) and "TOP" or "BOTTOM"
		local dx = hhalf == "RIGHT" and math.floor(self:GetRight() + 0.5) - w or math.floor(self:GetLeft() + 0.5)
		local dy = vhalf == "TOP" and math.floor(self:GetTop() + 0.5) - h or math.floor(self:GetBottom() + 0.5)

		if self:GetName() == "PhanxDebuffFrame" then
			db.debuffPoint, db.debuffX, db.debuffY = vhalf..hhalf, dx, dy
		else
			db.buffPoint, db.buffX, db.buffY = vhalf..hhalf, dx, dy
		end

		self:ClearAllPoints()
		self:SetPoint(vhalf..hhalf, UIParent, dx, dy)
	end

	lockFrames.OnClick = function(self, checked)
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

	self.refresh = function()
		buffSize:SetValue(db.buffSize)
		buffColumns:SetValue(db.buffColumns)
		debuffSize:SetValue(db.debuffSize)
		debuffColumns:SetValue(db.debuffColumns)
		iconSpacing:SetValue(db.iconSpacing)
		growthAnchor:SetValue(db.growthAnchor, anchors[db.growthAnchor])

		fontFace:SetValue(db.fontFace)
		fontOutline:SetValue(db.fontOutline, outlines[db.fontOutline])
		fontScale:SetValue(db.fontScale)
		maxTimer:SetValue(db.maxTimer)
		showBuffSources:SetChecked(db.showBuffSources)
		showTempEnchantSources:SetChecked(db.showTempEnchantSources)
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
		if cmd == L["buff"] then
			local ignoring = not PhanxBuffsIgnoreDB.buffs[name] and true or nil
			PhanxBuffsIgnoreDB.buffs[arg] = ignoring
			print("|cffffcc00PhanxBuffs:|r", string.format(ignoring and L["Now ignoring buff: %s."] or L["No longer ignoring buff: %s."], arg))
			return PhanxBuffFrame:Update()
		elseif cmd == L["debuff"] then
			local ignoring = not PhanxBuffsIgnoreDB.debuffs[name] and true or nil
			PhanxBuffsIgnoreDB.debuffs[arg] = ignoring
			print("|cffffcc00PhanxBuffs:|r", string.format(ignoring and L["Now ignoring debuff: %s."] or L["No longer ignoring debuff: %s."], arg))
			return PhanxDebuffFrame:Update()
		end
		return
	elseif cmd == L["buff"] then
		local t = { }
		for buff in pairs(PhanxBuffsIgnoreDB.buffs) do
			t[#t + 1] = buff
		end
		if #t == 0 then
			print("|cffffcc00PhanxBuffs:|r", L["No buffs are being ignored."])
		else
			table.sort(t)
			print("|cffffcc00PhanxBuffs:|r", L["%d |4buff:buffs; |4is:are; being ignored:"]:format(#t))
			for _, buff in ipairs(t) do
				print("   ", buff)
			end
		end
		return
	elseif cmd == L["debuff"] then
		local t = { }
		for debuff in pairs(PhanxBuffsIgnoreDB.debuffs) do
			t[#t + 1] = debuff
		end
		if #t == 0 then
			print("|cffffcc00PhanxBuffs:|r", L["No debuffs are being ignored."])
		else
			table.sort(t)
			print("|cffffcc00PhanxBuffs:|r", L["%d |4debuff:debuffs; |4is:are; being ignored:"]:format(#t))
			for _, debuff in ipairs(t) do
				print("   ", debuff)
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