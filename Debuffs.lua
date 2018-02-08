--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2018 Phanx <addons@phanx.net>. All rights reserved.
	https://github.com/Phanx/PhanxBuffs
	https://www.curseforge.com/wow/addons/phanxbuffs
	https://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
----------------------------------------------------------------------]]

local _, ns = ...

local PhanxDebuffFrame  = ns.CreateAuraFrame("PhanxDebuffFrame")
PhanxDebuffFrame.filter = "HARMFUL"
PhanxDebuffFrame.max    = 40
PhanxDebuffFrame.unit   = "player"

local newTable = ns.newTable
local remTable = ns.remTable
local GetFontFile = ns.GetFontFile

local ceil, floor, next, pairs, sort, tremove, type = math.ceil, math.floor, next, pairs, table.sort, table.remove, type -- Lua
local UnitAura = UnitAura -- WoW
local DebuffTypeSymbol = DebuffTypeSymbol -- FrameXML

local db

local DebuffTypeColor = {
	["Curse"]	= { 0.6, 0.0, 1 },
	["Disease"]	= { 0.6, 0.4, 0 },
	["Magic"]	= { 0.2, 0.6, 1 },
	["Poison"]	= { 0.0, 0.6, 0 },
}

------------------------------------------------------------------------

function PhanxDebuffFrame:PostInitialize()
	db = PhanxBuffsDB
	self.ignoreList = PhanxBuffsIgnoreDB.debuffs
end

function PhanxDebuffFrame:ApplySettings()
	self.anchorH = db.debuffAnchorH
	self.anchorV = db.debuffAnchorV
	self.size    = db.debuffSize
	self.spacing = db.debuffSpacing
	self.columns = db.debuffColumns
end

------------------------------------------------------------------------

local GetDispelMacro
do
	local _, class = UnitClass("player")
	if class == "DRUID" then
		function GetDispelMacro(dispelType)
			if IsPlayerSpell(88423) then
				-- Nature's Cure (Restoration)
				if dispelType == "Curse" or dispelType == "Poison" or dispelType == "Magic" then
					return "/cast [@player] " .. GetSpellInfo(88423)
				end
			elseif IsPlayerSpell(2782) then
				-- Remove Corruption (Balance, Feral, Guardian)
				if dispelType == "Curse" or dispelType == "Poison" then
					return "/cast [@player] " .. GetSpellInfo(2782)
				end
			end
		end
	elseif class == "MONK" then
		function GetDispelMacro(dispelType)
			if IsPlayerSpell(115450) then
				-- Detox (Mistweaver)
				if dispelType == "Disease" or dispelType == "Poison" or dispelType == "Magic" then
					return "/cast [@player] " .. GetSpellInfo(115450)
				end
			elseif IsPlayerSpell(218164) then
				-- Detox (Brewmaster, Windwalker)
				if dispelType == "Disease" or dispelType == "Poison" then
					return "/cast [@player] " .. GetSpellInfo(218164)
				end
			end
		end
	elseif class == "PALADIN" then
		function GetDispelMacro(dispelType)
			if IsPlayerSpell(4987) then
				-- Cleanse (Holy)
				if dispelType == "Disease" or dispelType == "Poison" or dispelType == "Magic" then
					return "/cast [@player] " .. GetSpellInfo(4987)
				end
			elseif IsPlayerSpell(213644) then
				-- Cleanse Toxins (Protection, Retribution)
				if dispelType == "Disease" or dispelType == "Poison" then
					return "/cast [@player] " .. GetSpellInfo(213644)
				end
			end
		end
	elseif class == "PRIEST" then
		function GetDispelMacro(dispelType)
			if IsPlayerSpell(527) then
				-- Purify (Discipline, Holy)
				if dispelType == "Disease" or dispelType == "Magic" then
					return "/cast [@player] " .. GetSpellInfo(527)
				end
			elseif IsPlayerSpell(213634) then
				-- Purify Disease (Shadow)
				if dispelType == "Disease" then
					return "/cast [@player] " .. GetSpellInfo(213634)
				end
			end
		end
	elseif class == "SHAMAN" then
		function GetDispelMacro(dispelType)
			if IsPlayerSpell(77130) then
				-- Purify Spirit (Restoration)
				if dispelType == "Curse" or dispelType == "Magic" then
					return "/cast [@player] " .. GetSpellInfo(77130)
				end
			elseif IsPlayerSpell(51886) then
				-- Cleanse Spirit (Elemental, Enhancement)
				if dispelType == "Curse" then
					return "/cast [@player] " .. GetSpellInfo(51886)
				end
			end
		end
	elseif class == "WARLOCK" then
		function GetDispelMacro(dispelType)
			if dispelType == "Magic" then
				if IsPlayerSpell(115276, true) then
					-- Sear Magic (Fel Imp)
					return "/cast [@player] " .. GetSpellInfo(115276)
				elseif IsPlayerSpell(89808, true) then
					-- Singe Magic (Imp)
					return "/cast [@player] " .. GetSpellInfo(89808)
				end
			end
		end
	end
end

local function AuraButton_OnEnter(self)
	if not self.index then return end

	GameTooltip:SetOwner(self, "ANCHOR_" .. (db.debuffAnchorV == "TOP" and "BOTTOM" or "TOP") .. (db.debuffAnchorH == "RIGHT" and "LEFT" or "RIGHT"))
	GameTooltip:SetUnitAura(self.owner.unit, self.index, self.owner.filter)

	if not InCombatLockdown() and (PhanxBuffsCancelButton.owner ~= self) then
		local macro = GetDispelMacro and GetDispelMacro(self.dispelType)
		if macro then
			PhanxBuffsCancelButton:SetMacro(self, macro)
		end
	end
end

local function AuraButton_OnClick(self)
	if self.name and IsAltKeyDown() and IsShiftKeyDown() then
		self.owner.ignoreList[self.name] = true
		print("|cffffcc00PhanxBuffs:|r", format(ns.L["Now ignoring debuff:"], self.name))
		self.owner:Update()
	end
end

local function AuraButton_SetBorderColor(self, ...)
	return self.border:SetVertexColor(...)
end

function PhanxDebuffFrame:PostCreateAuraButton(button)
	button:SetScript("OnEnter", AuraButton_OnEnter)
	button:SetScript("OnClick", AuraButton_OnClick)

	button.symbol = button:CreateFontString(nil, "OVERLAY")
	button.symbol:SetPoint("BOTTOMRIGHT", button)
	button.symbol:SetShadowOffset(1, -1)

	local file, scale, outline = GetFontFile(), db.fontScale, db.fontOutline
	button.symbol:SetFont(file, ns.SYMBOL_SIZE * scale, outline)

	if not PhanxBorder or (IsAddOnLoaded("Masque") and not db.noMasque) then
		button.border = button:CreateTexture(nil, "BORDER")
		button.border:SetPoint("TOPLEFT", button, -3, 2)
		button.border:SetPoint("BOTTOMRIGHT", button, 2, -2)
		button.border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays")
		button.border:SetTexCoord(0.296875, 0.5703125, 0, 0.515625)
		button.SetBorderColor = AuraButton_SetBorderColor
	end
end

------------------------------------------------------------------------

function PhanxDebuffFrame:PostUpdateAuraButton(button, isShown)
	if isShown then
		local color = DebuffTypeColor[button.dispelType]
		if color then
			button:SetBorderColor(color[1], color[2], color[3], 1)
			if ENABLE_COLORBLIND_MODE == "0" then
				button.symbol:Hide()
			else
				button.symbol:SetText(DebuffTypeSymbol[button.dispelType])
				button.symbol:Show()
			end
		else
			button:SetBorderColor(1, 0, 0, 1)
			button.symbol:Hide()
		end
	else
		button:SetBorderColor(1, 0, 0, 1)
		button.symbol:Hide()
		button.symbol:SetText()
	end
end

------------------------------------------------------------------------

function PhanxDebuffFrame:PostUpdateLayout()
	local fontFace = GetFontFile(db.fontFace)
	local fontScale = db.fontScale
	local fontOutline = db.fontOutline

	for i = 1, #self.buttons do
		local button = self.buttons[i]
		button.symbol:SetFont(fontFace, 16 * fontScale, fontOutline == "THICKOUTLINE" and fontOutline or "OUTLINE")
		if fontOutline == "THICKOUTLINE" then
			button.symbol:SetPoint("BOTTOMRIGHT", 2, 0)
		elseif fontOutline == "OUTLINE" then
			button.symbol:SetPoint("BOTTOMRIGHT", 0, 0)
		else
			button.symbol:SetPoint("BOTTOMRIGHT", 0, 0)
		end
	end

	if db.debuffPoint and db.debuffX and db.debuffY then
		self:SetPoint(db.debuffPoint, UIParent, db.debuffX, db.debuffY + 0.5)
	else
		self:SetPoint("BOTTOMRIGHT", UIParent, -70 - floor(Minimap:GetWidth() + 0.5), floor(UIParent:GetHeight() + 0.5) - floor(Minimap:GetHeight() + 0.5) - 62)
	end
end
