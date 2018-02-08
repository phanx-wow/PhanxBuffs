--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2018 Phanx <addons@phanx.net>. All rights reserved.
	https://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	https://www.curseforge.com/wow/addons/phanxbuffs
	https://github.com/Phanx/PhanxBuffs
----------------------------------------------------------------------]]

--local function print(...) ChatFrame3:AddMessage(strjoin(" ", tostringall(...))) end

local _, ns = ...

local PhanxBuffFrame = ns.CreateAuraFrame("PhanxBuffFrame")
PhanxBuffFrame.filter = "HELPFUL"
PhanxBuffFrame.max = 40
PhanxBuffFrame.unit = "player"

local newTable = ns.newTable
local remTable = ns.remTable
local GetFontFile = ns.GetFontFile

local L = ns.L
L["Cast by |cff%02x%02x%02x%s|r"] = gsub(L["Cast by %s"], "%%s", "|cff%%02x%%02x%%02x%%s|r")

local ceil, floor, next, pairs, sort, tonumber, type = math.ceil, math.floor, next, pairs, table.sort, tonumber, type -- Lua functions
local GetSpellInfo, UnitAura = GetSpellInfo, UnitAura -- API functions

local db

------------------------------------------------------------------------

function PhanxBuffFrame:PostInitialize()
	db = PhanxBuffsDB
	self.ignoreList = PhanxBuffsIgnoreDB.buffs
end

function PhanxBuffFrame:ApplySettings()
	self.anchorH = db.buffAnchorH
	self.anchorV = db.buffAnchorV
	self.size    = db.buffSize
	self.spacing = db.buffSpacing
	self.columns = db.buffColumns
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

local function AuraButton_OnEnter(self)
	if not self.index then return end

	GameTooltip:SetOwner(self, "ANCHOR_" .. (db.buffAnchorV == "TOP" and "BOTTOM" or "TOP") .. (db.buffAnchorH == "RIGHT" and "LEFT" or "RIGHT"))
	GameTooltip:SetUnitAura(self.owner.unit, self.index, self.owner.filter)

	if db.showBuffSources then
		local caster = unitNames[self.caster]
		if caster then
			GameTooltip:AddLine(caster)
			GameTooltip:Show()
		end
	end

	if not InCombatLockdown() and (PhanxBuffsCancelButton.owner ~= self) then
		PhanxBuffsCancelButton:SetMacro(self, "/cancelaura " .. self.name)
	end
end

local function AuraButton_OnClick(self)
	if self.name and IsAltKeyDown() and IsShiftKeyDown() then
		self.owner.ignoreList[self.name] = true
		print("|cffffcc00PhanxBuffs:|r", format(ns.L["Now ignoring buff: %s"], self.name))
		self.owner:Update()
	end
end

function PhanxBuffFrame:PostCreateAuraButton(button)
	button:SetScript("OnEnter", AuraButton_OnEnter)
	button:SetScript("OnClick", AuraButton_OnClick)
end

------------------------------------------------------------------------

function PhanxBuffFrame:GetLayoutOffset()
	return PhanxTempEnchantFrame.numEnchants
end

function PhanxBuffFrame:PostUpdateLayout()
	if db.buffPoint and db.buffX and db.buffY then
		self:SetPoint(db.buffPoint, UIParent, db.buffX, db.buffY)
	else
		self:SetPoint("TOPRIGHT", UIParent, -70 - floor(Minimap:GetWidth() + 0.5), -15)
	end
end
