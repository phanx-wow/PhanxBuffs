--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2016 Phanx <addons@phanx.net>. All rights reserved.
	https://github.com/Phanx/PhanxBuffs
	http://mods.curse.com/addons/wow/phanxbuffs
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
----------------------------------------------------------------------]]

local ADDON_NAME, ns = ...
local L = ns.L

ns.optionsPanel = LibStub("PhanxConfig-OptionsPanel").CreateOptionsPanel(ADDON_NAME, nil, function(self)
	local db = PhanxBuffsDB

	local title, notes = self:CreateHeader(ADDON_NAME, L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."])

	local function ApplySettings()
		for i = 1, #ns.auraFrames do
			ns.auraFrames[i]:ApplySettings()
			ns.auraFrames[i]:UpdateLayout()
		end
	end

	---------------------------------------------------------------------

	local buffSize = self:CreateSlider(L["Buff Size"], L["Adjust the size of each buff icon."], 10, 80, 2)
	buffSize:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -4, -8)
	buffSize:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, -8)

	function buffSize:OnValueChanged(value)
		db.buffSize = value
		ApplySettings()
	end

	---------------------------------------------------------------------

	local buffSpacing = self:CreateSlider(L["Buff Spacing"], L["Adjust the space between buff icons."], 0, 20, 1)
	buffSpacing:SetPoint("TOPLEFT", buffSize, "BOTTOMLEFT", 0, -12)
	buffSpacing:SetPoint("TOPRIGHT", buffSize, "BOTTOMRIGHT", 0, -12)

	function buffSpacing:OnValueChanged(value)
		db.buffSpacing = value
		ApplySettings()
	end

	---------------------------------------------------------------------

	local buffColumns = self:CreateSlider(L["Buff Columns"], L["Adjust the number of buff icons to show on each row."], 1, 40, 1)
	buffColumns:SetPoint("TOPLEFT", buffSpacing, "BOTTOMLEFT", 0, -12)
	buffColumns:SetPoint("TOPRIGHT", buffSpacing, "BOTTOMRIGHT", 0, -12)

	function buffColumns:OnValueChanged(value)
		db.buffColumns = value
		ApplySettings()
	end

	---------------------------------------------------------------------

	local buffAnchorV = self:CreateDropdown(L["Buff Anchor"], L["Choose whether the buff icons grow from top to bottom, or bottom to top."])
	buffAnchorV:SetPoint("TOPLEFT", buffColumns, "BOTTOMLEFT", 0, -12)
	buffAnchorV:SetPoint("TOPRIGHT", buffColumns, "BOTTOM", 0, -12)

	buffAnchorV:SetList({
		{ value = "TOP",    text = L["Top"]    },
		{ value = "BOTTOM", text = L["Bottom"] },
	})

	function buffAnchorV:OnValueChanged(value, text)
		db.buffAnchorV = value
		ApplySettings()
	end

	---------------------------------------------------------------------

	local buffAnchorH = self:CreateDropdown(L["Buff Anchor"], L["Choose whether the buff icons grow from left to right, or right to left."])
	buffAnchorH:SetPoint("TOPLEFT", buffColumns, "BOTTOM", 0, -12)
	buffAnchorH:SetPoint("TOPRIGHT", buffColumns, "BOTTOMRIGHT", 0, -12)

	buffAnchorH:SetList({
		{ value = "LEFT",  text = L["Left"]  },
		{ value = "RIGHT", text = L["Right"] },
	})

	function buffAnchorH:OnValueChanged(value, text)
		db.buffAnchorH = value
		ApplySettings()
	end

	buffAnchorH.labelText:Hide()
	buffAnchorV.labelText:SetPoint("TOPRIGHT", buffAnchorH, -5, 0)

	---------------------------------------------------------------------

	local debuffSize = self:CreateSlider(L["Debuff Size"], L["Adjust the size of each debuff icon."], 10, 80, 2)
	debuffSize:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -8)
	debuffSize:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)

	function debuffSize:OnValueChanged(value)
		db.debuffSize = value
		ApplySettings()
	end

	---------------------------------------------------------------------

	local debuffSpacing = self:CreateSlider(L["Debuff Spacing"], L["Adjust the space between debuff icons."], 0, 20, 1)
	debuffSpacing:SetPoint("TOPLEFT", debuffSize, "BOTTOMLEFT", 0, -12)
	debuffSpacing:SetPoint("TOPRIGHT", debuffSize, "BOTTOMRIGHT", 0, -12)

	function debuffSpacing:OnValueChanged(value)
		db.debuffSpacing = value
		ApplySettings()
	end

	---------------------------------------------------------------------

	local debuffColumns = self:CreateSlider(L["Debuff Columns"], L["Adjust the number of debuff icons to show on each row."], 1, 40, 1)
	debuffColumns:SetPoint("TOPLEFT", debuffSpacing, "BOTTOMLEFT", 0, -12)
	debuffColumns:SetPoint("TOPRIGHT", debuffSpacing, "BOTTOMRIGHT", 0, -12)

	function debuffColumns:OnValueChanged(value)
		db.debuffColumns = value
		ApplySettings()
	end

	---------------------------------------------------------------------

	local debuffAnchorV = self:CreateDropdown(L["Debuff Anchor"], L["Choose whether the debuff icons grow from top to bottom, or bottom to top."])
	debuffAnchorV:SetPoint("TOPLEFT", debuffColumns, "BOTTOMLEFT", 0, -12)
	debuffAnchorV:SetPoint("TOPRIGHT", debuffColumns, "BOTTOM", 0, -12)

	debuffAnchorV:SetList({
		{ value = "TOP",    text = L["Top"]    },
		{ value = "BOTTOM", text = L["Bottom"] },
	})

	function debuffAnchorV:OnValueChanged(value, text)
		db.debuffAnchorV = value
		ApplySettings()
	end

	---------------------------------------------------------------------

	local debuffAnchorH = self:CreateDropdown(L["Debuff Anchor"], L["Choose whether the debuff icons grow from left to right, or right to left."])
	debuffAnchorH:SetPoint("TOPLEFT", debuffColumns, "BOTTOM", 0, -12)
	debuffAnchorH:SetPoint("TOPRIGHT", debuffColumns, "BOTTOMRIGHT", 0, -12)

	debuffAnchorH:SetList({
		{ value = "LEFT",  text = L["Left"]  },
		{ value = "RIGHT", text = L["Right"] },
	})

	function debuffAnchorH:OnValueChanged(value, text)
		db.debuffAnchorH = value
		ApplySettings()
	end

	debuffAnchorH.labelText:Hide()
	debuffAnchorV.labelText:SetPoint("TOPRIGHT", debuffAnchorH, -5, 0)

	---------------------------------------------------------------------

	local fontFace = self:CreateMediaDropdown(L["Typeface"], L["Set the typeface for the stack count and timer text."], "font")
	fontFace:SetPoint("TOPLEFT", buffAnchorV, "BOTTOMLEFT", 0, -32)
	fontFace:SetPoint("TOPRIGHT", buffAnchorH, "BOTTOMRIGHT", 0, -32)

	function fontFace:OnValueChanged(value)
		db.fontFace = value
		for i = 1, #ns.auraFrames do
			ns.SetButtonFonts(ns.auraFrames[i], value)
		end
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
		for i = 1, #ns.auraFrames do
			ns.SetButtonFonts(ns.auraFrames[i], nil, value)
		end
	end

	---------------------------------------------------------------------

	local fontScale = self:CreateSlider(L["Text Size"], L["Adjust the size of the stack count and timer text."], 0.5, 1.5, 0.05, true)
	fontScale:SetPoint("TOPLEFT", fontOutline, "BOTTOMLEFT", 0, -12)
	fontScale:SetPoint("TOPRIGHT", fontOutline, "BOTTOMRIGHT", 0, -12)

	function fontScale:OnValueChanged(value)
		db.fontScale = value
		ApplySettings()
	end

	---------------------------------------------------------------------

	local maxTimer = self:CreateSlider(L["Max Timer Duration"], L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."], 0, 600, 30)
	maxTimer:SetPoint("TOPLEFT", debuffAnchorV, "BOTTOMLEFT", 0, -32)
	maxTimer:SetPoint("TOPRIGHT", debuffAnchorH, "BOTTOMRIGHT", 0, -32)

	function maxTimer:OnValueChanged(value)
		db.maxTimer = value
		ApplySettings()
	end

	---------------------------------------------------------------------

	local showBuffSources = self:CreateCheckbox(L["Show Buff Sources"], L["Show the name of the party or raid member who cast a buff on you in its tooltip."])
	showBuffSources:SetPoint("TOPLEFT", maxTimer, "BOTTOMLEFT", 0, -8)

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

		showBuffSources:SetChecked(db.showBuffSources)
	end
end)

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

		local db = PhanxBuffsDB
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
		InterfaceOptionsFrame_OpenToCategory(ns.optionsPanel)
	end
end
