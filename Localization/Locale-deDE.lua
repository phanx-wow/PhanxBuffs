--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
------------------------------------------------------------------------
	German Localization (Deutsch)
	Last updated YYYY-MM-DD by YourName
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "Lebensgeister"
L["Flametongue"] = "Flammenzunge"
L["Frostbrand"] = "Frostbrand"
L["Windfury"] = "Windzorn"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "Beruhigendes Gift"
L["Crippling Poison"] = "Verkrüppel" -- item: Verkrüppelndes Gift, enchant: Verkrüppelungsgift
L["Deadly Poison"] = "Tödliches Gift"
L["Instant Poison"] = "Sofort wirkendes Gift"
L["Mind-Numbing Poison"] = "Gedankenbenebelndes Gift"
L["Wound Poison"] = "Wundgift"

-- Warlock weapon enchant keywords

L["Firestone"] = "Feuerstein"
L["Spellstone"] = "Zauberstein"

-- Configuration panel

-- L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = ""
-- L["Buff Size"] = ""
-- L["Adjust the icon size for buffs."] = ""
-- L["Buff Spacing"] = ""
-- L["Adjust the space between icons for buffs."] = ""
-- L["Buff Sources"] = ""
-- L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = ""
-- L["Weapon Buff Sources"] = ""
-- L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = ""
-- L["Typeface"] = ""
-- L["Change the typeface for stack count and timer text."] = ""
-- L["Text Outline"] = ""
-- L["Change the outline weight for stack count and timer text."] = ""
-- L["None"] = ""
-- L["Thin"] = ""
-- L["Thick"] = ""
