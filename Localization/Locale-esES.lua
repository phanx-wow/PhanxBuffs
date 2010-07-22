--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
------------------------------------------------------------------------
	Spanish Localization (Español (EU) y Español (AL))
	Last updated YYYY-MM-DD by YourName
----------------------------------------------------------------------]]

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "Vida terrestre"
L["Flametongue"] = "Lengua de Fuego"
L["Frostbrand"] = "Estigma de Escarcha"
L["Rockbiter"] = "Muerdepiedras" -- needs check
L["Windfury"] = "Viento Furioso"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "Veneno anestésico"
L["Crippling Poison"] = "Veneno entorpecedor"
L["Deadly Poison"] = "Veneno mortal"
L["Instant Poison"] = "Veneno instantáneo"
L["Mind-Numbing Poison"] = "Veneno de aturdimiento mental"
L["Wound Poison"] = "Veneno hiriente"

-- Warlock weapon enchant keywords

L["Firestone"] = "Piedra de fuego"
L["Spellstone"] = "Piedra de hechizo"

-- Configuration panel text

-- L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = ""
-- L["Buff Size"] = ""
-- L["Set the size of each buff icon."] = ""
-- L["Buff Spacing"] = ""
-- L["Set the space between buff icons."] = ""
-- L["Buff Columns"] = ""
-- L["Set the number of buff icons to show on each row."] = ""
-- L["Debuff Size"] = ""
-- L["Set the size of each debuff icon."] = ""
-- L["Debuff Spacing"] = ""
-- L["Set the space between debuff icons."] = ""
-- L["Debuff Columns"] = ""
-- L["Set the number of debuff icons to show on each row."] = ""
-- L["Typeface"] = ""
-- L["Set the typeface for stack count and timer text."] = ""
-- L["Text Outline"] = ""
-- L["Set the outline weight for stack count and timer text."] = ""
-- L["None"] = ""
-- L["Thin"] = ""
-- L["Thick"] = ""
-- L["Growth Anchor"] = ""
-- L["Set the side of the screen from which buffs and debuffs grow."] = ""
-- L["Left"] = ""
-- L["Right"] = ""
-- L["Buff Sources"] = ""
-- L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = ""
-- L["Weapon Buff Sources"] = ""
-- L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = ""
-- L["Lock Frames"] = ""
-- L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = ""
