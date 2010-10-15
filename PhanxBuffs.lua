--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
----------------------------------------------------------------------]]

local db
local defaultDB = {
	buffColumns = 20,
	buffSize = 24,
	buffSpacing = 3,

	debuffColumns = 10,
	debuffSize = 48,
	debuffSpacing = 3,

	fontFace = "Friz Quadrata TT",
	fontOutline = "OUTLINE",

	growthAnchor = "RIGHT",

	showBuffSources = true,
	showTempEnchantSources = true,
}

------------------------------------------------------------------------

local _, ns = ...
if not ns.L then ns.L = { } end

local L = setmetatable(ns.L, { __index = function(t, k)
	if not k then return "" end
	local v = tostring(k)
	t[k] = v
	return v
end })

L["%d minutes remaining"] = SPELL_TIME_REMAINING_MIN -- "%d |4minute:minutes; remaining"
L["%d seconds remaining"] = SPELL_TIME_REMAINING_SEC -- "%d |4second:seconds; remaining"

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
	for i, button in ipairs(parent.buttons) do
		button.count:SetFont(file, baseSize * 0.6, outline)
		button.timer:SetFont(file, baseSize * 0.5, outline)
		if button.symbol then
			button.symbol:SetFont(file, baseSize * 0.6, outline)
		end
	end
end

------------------------------------------------------------------------

local optionsPanel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
optionsPanel.name = "PhanxBuffs"
optionsPanel:Hide()

optionsPanel:RegisterEvent("PLAYER_ENTERING_WORLD")
optionsPanel:SetScript("OnEvent", function(self)
	if not PhanxBuffsDB then PhanxBuffsDB = { } end
	db = PhanxBuffsDB

	for k, v in pairs(defaultDB) do
		if type(db[k]) ~= type(v) then
			db[k] = v
		end
	end

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

	BuffFrame:Hide()
	TemporaryEnchantFrame:Hide()
	BuffFrame:UnregisterAllEvents()

	PhanxBuffFrame:Load()
	PhanxDebuffFrame:Load()
	PhanxTempEnchantFrame:Load()

	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
end)

optionsPanel:SetScript("OnShow", function(self)
	local CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
	local CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown
	local CreateScrollingDropdown = LibStub("PhanxConfig-ScrollingDropdown").CreateScrollingDropdown
	local CreateSlider = LibStub("PhanxConfig-Slider").CreateSlider

	-------------------------------------------------------------------

	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetPoint("TOPRIGHT", -16, -16)
	title:SetJustifyH("LEFT")
	title:SetText(self.name)

	local notes = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	notes:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	notes:SetPoint("TOPRIGHT", title, 0, -8)
	notes:SetHeight(32)
	notes:SetJustifyH("LEFT")
	notes:SetJustifyV("TOP")
	notes:SetNonSpaceWrap(true)
	notes:SetText(L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."])

	-------------------------------------------------------------------

	local buffSize = CreateSlider(self, L["Buff Size"], 12, 48, 2)
	buffSize.desc = L["Set the size of each buff icon."]
	buffSize:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -4, -8)
	buffSize:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, -8)
	buffSize:SetValue(db.buffSize)

	buffSize.OnValueChanged = function(self, value)
		value = math.floor((value / 2) + 0.5) * 2

		db.buffSize = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()

		return value
	end

	-------------------------------------------------------------------

	local buffSpacing = CreateSlider(self, L["Buff Spacing"], 0, 8, 1)
	buffSpacing.desc = L["Set the space between buff icons."]
	buffSpacing:SetPoint("TOPLEFT", buffSize, "BOTTOMLEFT", 0, -12)
	buffSpacing:SetPoint("TOPRIGHT", buffSize, "BOTTOMRIGHT", 0, -12)
	buffSpacing:SetValue(db.buffSpacing)

	buffSpacing.OnValueChanged = function(self, value)
		value = math.floor(value + 0.5)

		db.buffSpacing = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()

		return value
	end

	-------------------------------------------------------------------

	local buffColumns = CreateSlider(self, L["Buff Columns"], 10, 40, 2)
	buffColumns.desc = L["Set the number of buff icons to show on each row."]
	buffColumns:SetPoint("TOPLEFT", buffSpacing, "BOTTOMLEFT", 0, -12)
	buffColumns:SetPoint("TOPRIGHT", buffSpacing, "BOTTOMRIGHT", 0, -12)
	buffColumns:SetValue(db.buffSpacing)

	buffColumns.OnValueChanged = function(self, value)
		value = math.floor(value + 0.5)

		db.buffColumns = value
		PhanxBuffFrame:UpdateLayout()
		PhanxTempEnchantFrame:UpdateLayout()

		return value
	end

	-------------------------------------------------------------------

	local debuffSize = CreateSlider(self, L["Debuff Size"], 12, 64, 2)
	debuffSize.desc = L["Set the size of each debuff icon."]
	debuffSize:SetPoint("TOPLEFT", buffColumns, "BOTTOMLEFT", 0, -12)
	debuffSize:SetPoint("TOPRIGHT", buffColumns, "BOTTOMRIGHT", 0, -12)
	debuffSize:SetValue(db.debuffSize)

	debuffSize.OnValueChanged = function(self, value)
		value = math.floor((value / 2) + 0.5) * 2

		db.debuffSize = value
		PhanxDebuffFrame:UpdateLayout()

		return value
	end

	-------------------------------------------------------------------

	local debuffSpacing = CreateSlider(self, L["Debuff Spacing"], 0, 8, 1)
	debuffSpacing.desc = L["Set the space between debuff icons."]
	debuffSpacing:SetPoint("TOPLEFT", debuffSize, "BOTTOMLEFT", 0, -12)
	debuffSpacing:SetPoint("TOPRIGHT", debuffSize, "BOTTOMRIGHT", 0, -12)
	debuffSpacing:SetValue(db.debuffSpacing)

	debuffSpacing.OnValueChanged = function(self, value)
		value = math.floor(value + 0.5)

		db.debuffSpacing = value
		PhanxDebuffFrame:UpdateLayout()

		return value
	end

	-------------------------------------------------------------------

	local debuffColumns = CreateSlider(self, L["Debuff Columns"], 10, 30, 2)
	debuffColumns.desc = L["Set the number of debuff icons to show on each row."]
	debuffColumns:SetPoint("TOPLEFT", debuffSpacing, "BOTTOMLEFT", 0, -12)
	debuffColumns:SetPoint("TOPRIGHT", debuffSpacing, "BOTTOMRIGHT", 0, -12)
	debuffColumns:SetValue(db.debuffSpacing)

	debuffColumns.OnValueChanged = function(self, value)
		value = math.floor(value + 0.5)

		db.debuffColumns = value
		PhanxDebuffFrame:UpdateLayout()

		return value
	end

	-------------------------------------------------------------------

	local fontFace = CreateScrollingDropdown(self, L["Typeface"], fonts)
	fontFace.desc = L["Set the typeface for stack count and timer text."]
	fontFace:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -8)
	fontFace:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)
	fontFace:SetValue(db.fontFace)
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

	-------------------------------------------------------------------

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
	fontOutline:SetValue(db.fontOutline, outlines[db.fontOutline])

	-------------------------------------------------------------------

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
	growthAnchor:SetPoint("TOPLEFT", fontOutline, "BOTTOMLEFT", 0, -12)
	growthAnchor:SetPoint("TOPRIGHT", fontOutline, "BOTTOMRIGHT", 0, -12)
	growthAnchor:SetValue(db.growthAnchor, anchors[db.growthAnchor])

	-------------------------------------------------------------------

	local showBuffSources = CreateCheckbox(self, L["Buff Sources"])
	showBuffSources.desc = L["Show the name of the party or raid member who cast a buff on you in its tooltip."]
	showBuffSources:SetPoint("TOPLEFT", growthAnchor, "BOTTOMLEFT", 2, -8)
	showBuffSources:SetChecked(db.showBuffSources)

	showBuffSources.OnClick = function(self, checked)
		db.showBuffSources = checked
	end

	-------------------------------------------------------------------

	local showTempEnchantSources = CreateCheckbox(self, L["Weapon Buff Sources"])
	showTempEnchantSources.desc = L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."]
	showTempEnchantSources:SetPoint("TOPLEFT", showBuffSources, "BOTTOMLEFT", 0, -8)
	showTempEnchantSources:SetChecked(db.showTempEnchantSources)

	showTempEnchantSources.OnClick = function(self, checked)
		db.showTempEnchantSources = checked
		PhanxTempEnchantFrame:Update()
	end

	-------------------------------------------------------------------

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

	-------------------------------------------------------------------

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(optionsPanel)

------------------------------------------------------------------------

local aboutPanel = LibStub("LibAboutPanel").new("PhanxBuffs", "PhanxBuffs")

------------------------------------------------------------------------

SLASH_PHANXBUFFS1 = "/pbuff"
SlashCmdList.PHANXBUFFS = function(input)
	if not input then return end

	if input:trim():len() > 0 then
		local type, name = input:match("^(%S+)%s*(.*)$")
		type = type:lower()

		if name then
			if type == L["buff"] then
				PhanxBuffsDB.ignoreBuffs[name] = PhanxBuffsDB.ignoreBuffs[name] and nil or true
				print("|cffffcc00PhanxBuffs:|r", string.format(PhanxBuffsDB.ignoreBuffs[name] and L["Now ignoring buff: %s"] or L["No longer ignoring buff: %s"], name))
				return
			elseif type == L["debuff"] then
				PhanxBuffsDB.ignoreDebuffs[name] = PhanxBuffsDB.ignoreDebuffs[name] and nil or true
				print("|cffffcc00PhanxBuffs:|r", string.format(PhanxBuffsDB.ignoreBuffs[name] and L["Now ignoring debuff: %s"] or L["No longer ignoring debuff: %s"], name))
				return
			end
		elseif input == L["buff"] then
			print("|cffffcc00PhanxBuffs:|r", L["Currently ignoring these buffs:"])
			for buff in pairs(PhanxBuffsDB.ignoreBuffs) do
				print("     ", buff)
			end
			return
		elseif input == L["debuff"] then
			print("|cffffcc00PhanxBuffs:|r", L["Currently ignoring these debuffs:"])
			for debuff in pairs(PhanxBuffsDB.ignoreDebuffs) do
				print("     ", debuff)
			end
			return
		end
	end

	InterfaceOptionsFrame_OpenToCategory(aboutPanel)
	InterfaceOptionsFrame_OpenToCategory(optionsPanel)
end

------------------------------------------------------------------------

ns.GetFontFile = GetFontFile
ns.SetButtonSize = SetButtonSize
ns.optionsPanel = optionsPanel
ns.aboutPanel = aboutPanel
