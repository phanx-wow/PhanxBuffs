--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
------------------------------------------------------------------------
	Simplified Chinese Localization (简体中文)
	Last updated 2011-10-20 by wowuicn
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

--	["Earthliving"] = "",
--	["Flametongue"] = "",
--	["Frostbrand"] = "",
--	["Rockbiter"] = "",
--	["Windfury"] = "",

-- Rogue weapon enchant keywords

--	["Crippling Poison"] = "",
--	["Deadly Poison"] = "",
--	["Instant Poison"] = "",
--	["Mind-Numbing Poison"] = "",
--	["Wound Poison"] = "",

-- Configuration panel

--	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "",
	["Buff Size"] = "Buff 大小",
--	["Adjust the size of each buff icon."] = "",
	["Buff Columns"] = "Buff 栏",
--	["Adjust the number of buff icons to show on each row."] = "",
	["Debuff Size"] = "Debuff 大小",
--	["Adjust the size of each debuff icon."] = "",
	["Debuff Columns"] = "Debuff 栏",
--	["Adjust the number of debuff icons to show on each row."] = "",
--	["Icon Spacing"] = "",
--	["Adjust the space between icons."] = "",
	["Growth Anchor"] = "增长锚点",
--	["Set the side of the screen from which buffs and debuffs grow."] = "",
	["Left"] = "左侧",
--	["Right"] = "",
--	["Typeface"] = "",
--	["Set the typeface for the stack count and timer text."] = "",
--	["Text Outline"] = "",
--	["Set the outline weight for the stack count and timer text."] = "",
--	["None"] = "",
--	["Thin"] = "",
--	["Thick"] = "",
--	["Text Size"] = "",
--	["Adjust the size of the stack count and timer text."] = ""
--	["Max Timer Duration"] = "",
--	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "",
	["Buff Sources"] = "Buff 来源",
--	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "",
--	["Weapon Buff Sources"] = "",
--	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "",
	["Lock Frames"] = "锁定框体",
--	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "",

	["Cast by %s"] = "来自 %s",

--	["Now ignoring buff: %s"] = "",
--	["Now ignoring debuff: %s"] = "",
--	["No longer ignoring buff: %s"] = "",
--	["No longer ignoring debuff: %s"] = "",
--	["No buffs are being ignored."] = "",
--	["No debuffs are being ignored."] = "",
--	["%d |4buff:buffs; |4is:are; being ignored:"] = "",
--	["%d |4debuff:debuffs; |4is:are; being ignored:"] = "",

}