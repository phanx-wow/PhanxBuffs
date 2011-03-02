--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
------------------------------------------------------------------------
	German Localization (Deutsch)
	Last updated YYYY-MM-DD by YourName
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "Lebensgeister",
	["Flametongue"] = "Flammenzunge",
	["Frostbrand"] = "Frostbrand",
	["Rockbiter"] = "Felsbeißers", -- needs check
	["Windfury"] = "Windzorn",

-- Rogue weapon enchant keywords

	["Anesthetic Poison"] = "Beruhigendes Gift",
	["Crippling Poison"] = "Verkrüppe[nu][dn][eg]s%s?[Gg]ift", -- item is Verkrüppelndes Gift, enchant is Verkrüppelungsgift
	["Deadly Poison"] = "Tödliches Gift",
	["Instant Poison"] = "Sofort wirkendes Gift",
	["Mind-Numbing Poison"] = "Gedankenbenebelndes Gift",
	["Wound Poison"] = "Wundgift",

-- Warlock weapon enchant keywords

	["Firestone"] = "Feuerstein",
	["Spellstone"] = "Zauberstein",

-- Configuration panel

--	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "",
--	["Buff Size"] = "",
--	["Set the size of each buff icon."] = "",
--	["Buff Spacing"] = "",
--	["Set the space between buff icons."] = "",
--	["Buff Columns"] = "",
--	["Set the number of buff icons to show on each row."] = "",
--	["Debuff Size"] = "",
--	["Set the size of each debuff icon."] = "",
--	["Debuff Spacing"] = "",
--	["Set the space between debuff icons."] = "",
--	["Debuff Columns"] = "",
--	["Set the number of debuff icons to show on each row."] = "",
--	["Typeface"] = "",
--	["Set the typeface for stack count and timer text."] = "",
--	["Text Outline"] = "",
--	["Set the outline weight for stack count and timer text."] = "",
--	["None"] = "",
--	["Thin"] = "",
--	["Thick"] = "",
--	["Growth Anchor"] = "",
--	["Set the side of the screen from which buffs and debuffs grow."] = "",
--	["Left"] = "",
--	["Right"] = "",
--	["Buff Sources"] = "",
--	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "",
--	["Weapon Buff Sources"] = "",
--	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "",
--	["Lock Frames"] = "",
--	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "",

--	["Cast by %s"] = "",

--	["Now ignoring buff: %s"] = "",
--	["No longer ignoring buff: %s"] = "",
--	["Now ignoring debuff: %s"] = "",
--	["No longer ignoring debuff: %s"] = "",
--	["No buffs are being ignored:"] = "",
--	["%d buffs are being ignored:"] = "",
--	["No debuffs are being ignored:"] = "",
--	["%d debuffs are being ignored:"] = "",

}