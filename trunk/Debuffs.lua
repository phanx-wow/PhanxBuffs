--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
----------------------------------------------------------------------]]

local PhanxDebuffFrame = CreateFrame("Frame", "PhanxDebuffFrame", UIParent)

local db
local ignore = {
	["Bested Darnassus"] = true,
	["Bested Gnomeregan"] = true,
	["Bested Ironforge"] = true,
	["Bested Orgrimmar"] = true,
	["Bested Sen'jin"] = true,
	["Bested Silvermoon City"] = true,
	["Bested Stormwind"] = true,
	["Bested the Exodar"] = true,
	["Bested the Undercity"] = true,
	["Bested Thunder Bluff"] = true,
	["Chill of the Throne"] = true,
	["Weakened Soul"] = true,
}

local debuffs = { }
local debuffUnit = "player"

local DebuffTypeColor = {
	["Magic"]	= { 0.2, 0.6, 1 },
	["Curse"]	= { 0.6, 0.0, 1 },
	["Disease"]	= { 0.6, 0.4, 0 },
	["Poison"]	= { 0.0, 0.6, 0 },
}

local _, ns = ...
local GetFontFile = ns.GetFontFile

------------------------------------------------------------------------

local function button_OnEnter(self)
	local debuff = debuffs[self:GetID()]
	if not debuff then return end

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
	GameTooltip:SetUnitAura(debuffUnit, debuff.index, "HARMFUL")
end

local function button_OnLeave()
	GameTooltip:Hide()
end

local buttons = setmetatable({ }, { __index = function(t, i)
	local f = CreateFrame("Button", nil, PhanxDebuffFrame)
	f:SetID(i)
	f:SetWidth(db.debuffSize)
	f:SetHeight(db.debuffSize)
	f:Show()

	if i == 1 then
		f:SetPoint("BOTTOMRIGHT", PhanxDebuffFrame, 0, PhanxBorder and 1 or 0)
	else
		f:SetPoint("BOTTOMRIGHT", t[i - 1], "BOTTOMLEFT", -db.debuffSpacing, 0)
	end

	f:EnableMouse(true)
	f:SetScript("OnEnter", button_OnEnter)
	f:SetScript("OnLeave", button_OnLeave)

	f.icon = f:CreateTexture(nil, "BACKGROUND")
	f.icon:SetAllPoints(f)

	f.count = f:CreateFontString(nil, "OVERLAY")
    f.count:SetPoint("CENTER", f, "TOP")
	f.count:SetFont(GetFontFile(db.fontFace), 14, "OUTLINE")

	f.timer = f:CreateFontString(nil, "OVERLAY")
	f.timer:SetPoint("TOP", f, "BOTTOM")
	f.timer:SetFont(GetFontFile(db.fontFace), 12, "OUTLINE")

	if PhanxBorder then
		PhanxBorder.AddBorder(f, 11)
		f.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	else
		f.border = f:CreateTexture(nil, "BORDER")
		f.border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays")
		f.border:SetAllPoints(f)
		f.border:SetTexCoord(0.296875, 0.5703125, 0, 0.515625)
		f.SetBorderColor = function(...) return f.border:SetVertexColor(...) end
	end

	f.symbol = f:CreateFontString(nil, "OVERLAY")
	f.symbol:SetPoint("TOPLEFT", 2, -2)
	f.symbol:SetFont(GetFontFile(db.fontFace), 10, "OUTLINE")

	t[i] = f
	return f
end })

PhanxDebuffFrame.buttons = buttons

------------------------------------------------------------------------

local function DebuffSort(a, b)
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

local tablePool = { }

local function newTable()
	local t = next(tablePool) or { }
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

function PhanxDebuffFrame:UpdateDebuffs()
	for i, t in ipairs(debuffs) do
		debuffs[i] = remTable(t)
	end

	local i = 1
	while true do
		local name, _, icon, count, kind, duration, expires, caster, _, _, spellID = UnitAura(debuffUnit, i, "HARMFUL")
		if not name then break end

		if not db.ignoreDebuffs[name] then
			local n = #debuffs + 1
			debuffs[n] = newTable()
			local t = debuffs[n]

			t.name = name
			t.icon = icon
			t.count = count
			t.kind = kind
			t.duration = duration or 0
			t.expires = expires
			t.caster = caster
			t.spellID = spellID
			t.index = i
		end

		i = i + 1
	end

	table.sort(debuffs, DebuffSort)

	for i, debuff in ipairs(debuffs) do
		local f = buttons[i]
		f.icon:SetTexture(debuff.icon)

		if debuff.count > 1 then
			f.count:SetText(debuff.count)
		else
			f.count:SetText()
		end

		local debuffTypeColor = DebuffTypeColor[debuff.kind]
		if debuffTypeColor then
			f:SetBorderColor(unpack(debuffTypeColor))
			if ENABLE_COLORBLIND_MODE == "1" then
				f.symbol:Show()
				f.symbol:SetText(DebuffTypeSymbol[debuff.kind])
			else
				f.symbol:Hide()
			end
		else
			f:SetBorderColor(1, 0, 0)
			f.symbol:Hide()
		end

		f:Show()
	end

	if #buttons > #debuffs then
		for i = #debuffs + 1, #buttons do
			local f = buttons[i]
			f.icon:SetTexture()
			f.count:SetText()
			f:Hide()
		end
	end
end

------------------------------------------------------------------------

local counter, dirty = 0
function PhanxDebuffFrame:OnUpdate(elapsed)
	counter = counter + elapsed
	if counter > 0.1 then
		if dirty then
			self:UpdateDebuffs()
			dirty = false
		end
		for i, button in ipairs(buttons) do
			if not button:IsShown() then break end

			local debuff = debuffs[button:GetID()]
			if debuff then
				if debuff.expires > 0 then
					local remaining = debuff.expires - GetTime()
					if remaining < 0 then
						-- bugged out, kill it
						remTable( table.remove(debuffs, button:GetID()) )
						dirty = true
					elseif remaining <= 30.5 then
						button.timer:SetText( math.floor(remaining + 0.5) )
					else
						button.timer:SetText()
					end
				else
					button.timer:SetText()
				end
			end
		end
		counter = 0
	end
end

PhanxDebuffFrame:SetScript("OnEvent", function(self, event, unit)
	if event == "UNIT_AURA" then
		if unit == debuffUnit then
			dirty = true
		end
	return end
	if event == "PLAYER_ENTERING_WORLD" then
		debuffUnit = UnitInVehicle("player") and "vehicle" or "player"
		dirty = true
	return end
	if event == "UNIT_ENTERING_VEHICLE" then
		if unit == "player" then
			debuffUnit = "vehicle"
			dirty = true
		end
	return end
	if event == "UNIT_EXITING_VEHICLE" then
		if unit == "player" then
			debuffUnit = "player"
			dirty = true
		end
	return end
end)

------------------------------------------------------------------------

function PhanxDebuffFrame:Load()
	if db then return end

	db = PhanxBuffsDB
	for k, v in pairs(ignore) do
		db.ignoreDebuffs[k] = v
	end

	self:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -6, -2)
	self:SetWidth(UIParent:GetWidth() - Minimap:GetWidth() - 45)
	self:SetHeight(db.debuffSize)

	dirty = true
	self:SetScript("OnUpdate", self.OnUpdate)

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_ENTERING_VEHICLE")
	self:RegisterEvent("UNIT_EXITING_VEHICLE")
	self:RegisterEvent("UNIT_AURA")
end
