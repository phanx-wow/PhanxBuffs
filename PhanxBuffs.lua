--[[--------------------------------------------------------------------
	PhanxBuffs
----------------------------------------------------------------------]]

local db
local defaultDB = {
	buffSize = 24,
	buffSpacing = 3,
	debuffSize = 48,
	debuffSpacing = 3,
	fontFace = "Friz Quadrata TT",
	fontOutline = "OUTLINE",
	ignoreBuffs = { },
	ignoreDebuffs = { },
	showBuffSources = true,
	showTempEnchantSources = true,
}

------------------------------------------------------------------------

local L = setmetatable({ }, { __index = function(t, k)
	if not k then return "" end
	local v = tostring(k)
	t[k] = v
	return v
end })

------------------------------------------------------------------------

local fonts = { }

local defaultFonts = {
	["Arial Narrow"] = [[Fonts\ARIALN.TTF]],
	["Friz Quadrata TT"] = [[Fonts\FRIZQT__.TTF]],
	["Morpheus"] = [[Fonts\MORPHEUS.ttf]],
	["Skurri"] = [[Fonts\skurri.ttf]],
}

local SharedMedia

------------------------------------------------------------------------

function SetButtonSize(parent, size)
	for i, button in ipairs(parent.buttons) do
		button:SetWidth(size)
		button:SetHeight(size)
	end
end

------------------------------------------------------------------------

function SetButtonSpacing(parent, spacing)
	for i, button in ipairs(parent.buttons) do
		if i > 1 then
			button:ClearAllPoints()
			button:SetPoint("RIGHT", parent.buttons[i - 1], "LEFT", -spacing, 0)
		end
	end
end

------------------------------------------------------------------------

local function GetFontFile(name)
	local file = SharedMedia and SharedMedia:Fetch("font", name) or defaultFonts[name]
	return file or [[Fonts\FRIZQT__.TTF]]
end

local function SetButtonFonts(parent, face, outline)
	if not face then face = db.fontFace end
	if not outline then outline = db.fontOutline end

	local file = GetFontFile(face)

	local size, _
	for i, button in ipairs(parent.buttons) do
		_, size, _ = button.count:GetFont()
		button.count:SetFont(file, size, outline)

		_, size, _ = button.timer:GetFont()
		button.timer:SetFont(file, size, outline)

		if button.symbol then
			_, size, _ = button.symbol:GetFont()
			button.symbol:SetFont(file, size, outline)
		end
	end
end

------------------------------------------------------------------------

local optionsPanel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
optionsPanel.name = "PhanxBuffs"
optionsPanel:Hide()

optionsPanel:RegisterEvent("PLAYER_LOGIN")
optionsPanel:SetScript("OnEvent", function(self)
	PhanxBuffsDB = PhanxBuffsDB or { }
	db = PhanxBuffsDB

	for k, v in pairs(defaultDB) do
		if type(db[k]) ~= type(v) then
			db[k] = v
		end
	end

	SharedMedia = LibStub("LibSharedMedia-3.0", true)

	if SharedMedia then
		for name, file in pairs(defaultFonts) do
			if file:match("^Interface\\AddOns") then
				SharedMedia:Register("font", name, file)
			end
		end
		for i, v in pairs(SharedMedia:List("font")) do
			table.insert(fonts, v)
		end
		table.sort(fonts)

		function self:SharedMedia_Registered(_, mediaType, mediaName)
			if mediaType == "font" then
				table.insert(fonts, mediaName)
				table.sort(fonts)

				SetButtonFonts(PhanxBuffFrame)
				SetButtonFonts(PhanxDebuffFrame)
				SetButtonFonts(PhanxTempEnchantFrame)
			end
		end

		SharedMedia.RegisterCallback(self, "LibSharedMedia_Registered", "SharedMedia_Registered")

		function self:SharedMedia_SetGlobal(_, mediaType)
			if mediaType == "font" then
				SetButtonFonts(PhanxBuffFrame)
				SetButtonFonts(PhanxDebuffFrame)
				SetButtonFonts(PhanxTempEnchantFrame)
			end
		end

		SharedMedia.RegisterCallback(self, "LibSharedMedia_SetGlobal",  "SharedMedia_SetGlobal")
	else
		for name in pairs(defaultFonts) do
			table.insert(fonts, name)
		end
		table.sort(fonts)
	end

	PhanxBuffFrame:Load()
	PhanxDebuffFrame:Load()
	PhanxTempEnchantFrame:Load()

	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
end)

optionsPanel:SetScript("OnShow", function(self)
--	self.CreatePanel = LibStub("PhanxConfig-Panel").CreatePanel
	self.CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
--	self.CreateColorPicker = LibStub("PhanxConfig-ColorPicker").CreateColorPicker
	self.CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown
	self.CreateScrollingDropdown = LibStub("PhanxConfig-ScrollingDropdown").CreateScrollingDropdown
	self.CreateSlider = LibStub("PhanxConfig-Slider").CreateSlider

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

	local buffSize = self:CreateSlider(L["Buff Size"], 12, 48, 2)
	buffSize.desc = L["Increase or decrese the size of buff icons."]
	buffSize.container:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -4, -8)
	buffSize.container:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, -8)
	buffSize.valueText:SetText(db.buffSize)
	buffSize:SetValue(db.buffSize)
	function buffSize:OnValueChanged(value)
		value = math.floor((value / 2) + 0.5) * 2
		db.buffSize = value
		SetButtonSize(PhanxBuffFrame, value)
		SetButtonSize(PhanxTempEnchantFrame, value)
		return value
	end

	-------------------------------------------------------------------

	local buffSpacing = self:CreateSlider(L["Buff Spacing"], 0, 8, 1)
	buffSpacing.desc = L["Increase or decrese the spacing between buff icons."]
	buffSpacing.container:SetPoint("TOPLEFT", buffSize.container, "BOTTOMLEFT", 0, -12)
	buffSpacing.container:SetPoint("TOPRIGHT", buffSize.container, "BOTTOMRIGHT", 0, -12)
	buffSpacing.valueText:SetText(db.buffSpacing)
	buffSpacing:SetValue(db.buffSpacing)
	function buffSpacing:OnValueChanged(value)
		value = math.floor(value + 0.5)
		db.buffSpacing = value
		SetButtonSpacing(PhanxBuffFrame, value)
		SetButtonSpacing(PhanxTempEnchantFrame, value)
		return value
	end

	-------------------------------------------------------------------

	local debuffSize = self:CreateSlider(L["Debuff Size"], 12, 48, 2)
	debuffSize.desc = L["Increase or decrese the size of debuff icons."]
	debuffSize.container:SetPoint("TOPLEFT", buffSpacing.container, "BOTTOMLEFT", 0, -12)
	debuffSize.container:SetPoint("TOPRIGHT", buffSpacing.container, "BOTTOMRIGHT", 0, -12)
	debuffSize.valueText:SetText(db.debuffSize)
	debuffSize:SetValue(db.debuffSize)
	function debuffSize:OnValueChanged(value)
		value = math.floor((value / 2) + 0.5) * 2
		db.debuffSize = value
		SetButtonSize(PhanxDebuffFrame, value)
		return value
	end

	-------------------------------------------------------------------

	local debuffSpacing = self:CreateSlider(L["Debuff Spacing"], 0, 8, 1)
	debuffSpacing.desc = L["Increase or decrese the spacing between debuff icons."]
	debuffSpacing.container:SetPoint("TOPLEFT", debuffSize.container, "BOTTOMLEFT", 0, -12)
	debuffSpacing.container:SetPoint("TOPRIGHT", debuffSize.container, "BOTTOMRIGHT", 0, -12)
	debuffSpacing.valueText:SetText(db.debuffSpacing)
	debuffSpacing:SetValue(db.debuffSpacing)
	function debuffSize:OnValueChanged(value)
		value = math.floor(value + 0.5)
		db.debuffSpacing = value
		SetButtonSpacing(PhanxDebuffFrame, value)
		return value
	end

	-------------------------------------------------------------------

	local fontFace = self:CreateScrollingDropdown(L["Font Face"], fonts)
	fontFace.container.desc = L["Change the font face for stack count and timer text."]
	fontFace.container:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -8)
	fontFace.container:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)
	fontFace.valueText:SetText(db.font)
	do
		local _, height, flags = fontFace.valueText:GetFont()
		fontFace.valueText:SetFont(GetFontFile(db.font), height, flags)

		function fontFace:OnValueChanged(value)
			db.font = value

			SetButtonFonts(PhanxBuffFrame, value)
			SetButtonFonts(PhanxDebuffFrame, value)
			SetButtonFonts(PhanxTempEnchantFrame, value)

			local _, height, flags = self.valueText:GetFont()
			self.valueText:SetFont(GetFontFile(value), height, flags)
		end

		local button_OnClick = fontFace.button:GetScript("OnClick")
		fontFace.button:SetScript("OnClick", function(self)
			button_OnClick(self)
			fontFace.list:Hide()

			local function SetButtonFonts(self)
				local buttons = fontFace.list.buttons
				for i = 1, #buttons do
					local button = buttons[i]
					if button.value and button:IsShown() then
						button.label:SetFont(GetFontFile(button.value), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
					end
				end
			end

			local OnShow = fontFace.list:GetScript("OnShow")
			fontFace.list:SetScript("OnShow", function(self)
				OnShow(self)
				SetButtonFonts(self)
			end)

			local OnVerticalScroll = fontFace.list.scrollFrame:GetScript("OnVerticalScroll")
			fontFace.list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
				OnVerticalScroll(self, delta)
				SetButtonFonts(self)
			end)

			local SetText = fontFace.list.text.SetText
			fontFace.list.text.SetText = function(self, text)
				self:SetFont(GetFontFile(text), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT + 1)
				SetText(self, text)
			end

			button_OnClick(self)
			self:SetScript("OnClick", button_OnClick)
		end)
	end

	-------------------------------------------------------------------

	local fontOutline = self:CreateDropdown(L["Outline"])
	fontOutline.container.desc = L["Change the outline for stack count and timer text."]
	fontOutline.container:SetPoint("TOPLEFT", fontFace.container, "BOTTOMLEFT", 0, -12)
	fontOutline.container:SetPoint("TOPRIGHT", fontFace.container, "BOTTOMRIGHT", 0, -12)
	do
		local outlines = { ["NONE"] = L["None"], ["OUTLINE"] = L["Thin"], ["THICKOUTLINE"] = L["Thick"] }

		local function OnClick(self)
			local value = self.value

			db.fontOutline = value

			SetButtonFonts(PhanxBuffFrame, nil, value)
			SetButtonFonts(PhanxDebuffFrame, nil, value)
			SetButtonFonts(PhanxTempEnchantFrame, nil, value)

			fontOutline.valueText:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(fontOutline, self.value)
		end

		local info = { } -- UIDropDownMenu_CreateInfo()
		UIDropDownMenu_Initialize(fontOutline, function(self)
			local selected = outlines[UIDropDownMenu_GetSelectedValue(fontOutline)] or self.valueText:GetText()

			info.text = L["None"]
			info.value = "NONE"
			info.func = OnClick
			info.checked = L["None"] == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Thin"]
			info.value = "OUTLINE"
			info.func = OnClick
			info.checked = L["Thin"] == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Thick"]
			info.value = "THICKOUTLINE"
			info.func = OnClick
			info.checked = L["Thick"] == selected
			UIDropDownMenu_AddButton(info)
		end)

		fontOutline.valueText:SetText(outlines[db.fontOutline] or L["None"])
		UIDropDownMenu_SetSelectedValue(fontOutline, db.fontOutline or L["None"])
	end

	-------------------------------------------------------------------

	local showBuffSources = self:CreateCheckbox(L["Buff Sources"])
	showBuffSources.desc = L["Show the name of the player who cast buffs in their tooltips."]
	showBuffSources:SetPoint("TOPLEFT", fontOutline.container, "BOTTOMLEFT", 0, -24)
	showBuffSources:SetChecked(db.showBuffSources)
	function showBuffSources:OnClick(checked)
		db.showBuffSources = checked
	end

	-------------------------------------------------------------------

	local showTempEnchantSources = self:CreateCheckbox(L["Weapon Buff Sources"])
	showTempEnchantSources.desc = L["Show weapon buffs as the buffing spell or item, instead of the buffed weapon."]
	showTempEnchantSources:SetPoint("TOPLEFT", showBuffSources, "BOTTOMLEFT", 0, -28)
	showTempEnchantSources:SetChecked(db.showTempEnchantSources)
	function showTempEnchantSources:OnClick(checked)
		db.showTempEnchantSources = checked
		PhanxTempEnchantFrame:UpdateTempEnchants()
	end

	-------------------------------------------------------------------

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(optionsPanel)

local AboutPanel = LibStub("LibAboutPanel", true)
if AboutPanel then
	AboutPanel.new("PhanxBuffs", "PhanxBuffs")
end

SLASH_PhanxBuffs1 = "/pbuff"
SlashCmdList.PhanxBuffs = function() InterfaceOptionsFrame_OpenToCategory(optionsPanel) end

------------------------------------------------------------------------

BuffFrame:Hide()
TemporaryEnchantFrame:Hide()
BuffFrame:UnregisterAllEvents()

local _, ns = ...
ns.L = L
ns.GetFontFile = GetFontFile
ns.optionsPanel = optionsPanel