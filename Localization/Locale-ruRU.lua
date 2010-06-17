--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
------------------------------------------------------------------------
	Russian Localization (Русский)
	Last updated YYYY-MM-DD by YourName
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "Жизнь Земли"
L["Flametongue"] = "Язык пламени"
L["Frostbrand"] = "Ледяное клеймо"
L["Windfury"] = "Неистовство ветра"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "Анестезирующий яд"
L["Crippling Poison"] = "Калечащий яд"
L["Deadly Poison"] = "Смертельный яд"
L["Instant Poison"] = "Быстродействующий яд"
L["Mind-Numbing Poison"] = "Дурманящий яд"
L["Wound Poison"] = "Нейтрализующий яд"

-- Warlock weapon enchant keywords

L["Firestone"] = "камень огня"
L["Spellstone"] = "камень чар"

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
