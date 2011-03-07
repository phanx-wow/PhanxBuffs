--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
------------------------------------------------------------------------
	Traditional Chinese Localization (正體中文)
	Last updated 2010-07-20 by fmdsm on curse.com
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "大地生命",
	["Flametongue"] = "火舌",
	["Frostbrand"] = "冰封",
--	["Rockbiter"] = "",
	["Windfury"] = "風怒",

-- Rogue weapon enchant keywords

	["Anesthetic Poison"] = "麻醉",
	["Crippling Poison"] = "致殘",
	["Deadly Poison"] = "致命",
	["Instant Poison"] = "速效",
	["Mind-Numbing Poison"] = "麻痹",
	["Wound Poison"] = "致傷",

-- Warlock weapon enchant keywords

	["Firestone"] = "火焰石",
	["Spellstone"] = "法術石",

-- Configuration panel

	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "這裡可以調整buff,debuff,武器附魔圖示的基本設置.",
	["Buff Size"] = "buff大小",
	["Set the size of each buff icon."] = "設置buff圖示大小",
	["Buff Spacing"] = "buff間距",
	["Set the space between buff icons."] = "設置buff圖示間距",
	["Buff Columns"] = "buff列數",
	["Set the number of buff icons to show on each row."] = "設置buff圖示每行顯示的個數",
	["Debuff Size"] = "debuff大小",
	["Set the size of each debuff icon."] = "設置debuff圖示大小",
	["Debuff Spacing"] = "debuff間距",
	["Set the space between debuff icons."] = "設置debuff圖示間距",
	["Debuff Columns"] = "debuff列數",
	["Set the number of debuff icons to show on each row."] = "設置debuff圖示每行顯示的個數",
	["Typeface"] = "字型",
	["Set the typeface for stack count and timer text."] = "設置層數和時間文字字型",
	["Text Outline"] = "文本輪廓",
	["Set the outline weight for stack count and timer text."] = "設置層數和時間文字輪廓",
	["None"] = "無",
	["Thin"] = "細",
	["Thick"] = "粗",
--	["Text Size"] = "",
--	["Adjust the size of the stack count and timer text."] = "",
	["Growth Anchor"] = "描點對齊",
	["Set the side of the screen from which buffs and debuffs grow."] = "設置buff和debuff從屏幕哪邊對齊.",
	["Left"] = "左",
	["Right"] = "右",
	["Buff Sources"] = "buff來源",
	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "在提示上顯示buff施放者的名字.",
	["Weapon Buff Sources"] = "武器附魔來源",
	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "顯示武器附魔圖示用附魔物品或法術來取代武器本身.",
	["Lock Frames"] = "鎖定框架",
	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "鎖定buff和debuff框架,隱藏背景防止被移動.",

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