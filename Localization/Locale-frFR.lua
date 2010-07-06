--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
------------------------------------------------------------------------
	French Localization (Français)
	Last updated YYYY-MM-DD by YourName
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "Viveterre"
L["Flametongue"] = "Langue de feu"
L["Frostbrand"] = "Arme de givre"
L["Windfury"] = "Furie-des-vents"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "Poison anesthésiant"
L["Crippling Poison"] = "Poison affaiblissant"
L["Deadly Poison"] = "Poison mortel"
L["Instant Poison"] = "Poison instantané"
L["Mind-Numbing Poison"] = "Poison de Distraction mentale" -- item name has lowercase d
L["Wound Poison"] = "Poison douloureux"

-- Warlock weapon enchant keywords

L["Firestone"] = "Pierre de feu"
L["Spellstone"] = "Pierre de sort"

-- Configuration panel

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
