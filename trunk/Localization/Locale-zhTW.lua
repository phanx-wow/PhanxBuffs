--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
------------------------------------------------------------------------
	Traditional Chinese Localization (繁體中文)
	Last updated 2012-09-10 by BNSSNB @ CurseForge
	Previously updated by fmdsm @ CurseForge
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "大地生命",
	["Flametongue"] = "火舌",
	["Frostbrand"] = "冰封",
	["Rockbiter"] = "石化",
	["Windfury"] = "風怒",

-- Rogue weapon enchant keywords

	["Crippling Poison"] = "致殘",
	["Deadly Poison"] = "致命",
	["Leeching Poison"] = "吸血毒藥",
	["Mind-Numbing Poison"] = "麻痹",
	["Paralytic Poison"] = "麻痺毒藥",
	["Wound Poison"] = "致傷",

-- Configuration panel

	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "這裡可以調整buff,debuff,武器附魔圖示的基本設置.",

	["Buff Size"] = "buff大小",
	["Adjust the size of each buff icon."] = "設置buff圖示大小",
	["Buff Spacing"] = "buff間距",
	["Adjust the space between buff icons."] = "設置buff圖示間距",
	["Buff Columns"] = "buff列數",
	["Adjust the number of buff icons to show on each row."] = "設置buff圖示每行顯示的個數",
	["Buff Anchor"] = "buff描點對齊",
	["Choose whether the buff icons grow from left to right, or right to left."] = "選擇增益圖標是從左到右伸展，還是從右到左。",
	["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "選擇增益圖標是從上往下延展，還是從下到上。",

	["Debuff Size"] = "debuff大小",
	["Adjust the size of each debuff icon."] = "設置debuff圖示大小",
	["Debuff Spacing"] = "debuff間距",
	["Adjust the space between debuff icons."] = "設置debuff圖示間距",
	["Debuff Columns"] = "debuff列數",
	["Adjust the number of debuff icons to show on each row."] = "設置debuff圖示每行顯示的個數",
	["Debuff Anchor"] = "debuff描點對齊",
	["Choose whether the debuff icons grow from left to right, or right to left."] = "選擇減益圖標是從左到右伸展，還是從右到左。",
	["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "選擇減益圖標是從上往下延展，還是從下到上。",

	["Top"] = "頂部",
	["Bottom"] = "底部",
	["Left"] = "左",
	["Right"] = "右",

	["Typeface"] = "字型",
	["Set the typeface for the stack count and timer text."] = "設置層數和時間文字字型",
	["Text Outline"] = "文本輪廓",
	["Set the outline weight for the stack count and timer text."] = "設置層數和時間文字輪廓",
	["None"] = "無",
	["Thin"] = "細",
	["Thick"] = "粗",
	["Text Size"] = "文字大小",
	["Adjust the size of the stack count and timer text."] = "調整堆疊計數和計時的文字大小。",

	["Max Timer Duration"] = "最大計時期間",
	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "調整顯示buff或debuff的計時文字，最大的提醒期間，以秒數計。",

	["Buff Sources"] = "buff來源",
	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "在提示上顯示buff施放者的名字",
	["Weapon Buff Sources"] = "武器附魔來源",
	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "顯示武器附魔圖示用附魔物品或法術來取代武器本身",
	["One-Click Cancel"] = "一鍵取消",
	["Cancel unprotected buffs on the first click, instead of the second. Only works out of combat, and protected buffs like shapeshift forms and weapon buffs will still require two clicks."] = "單次點擊取消未受保護的buffs而不是兩次，但只有非戰鬥時有用，並且受保護的buffs類似形狀改變的型態與武器buffs仍然需要兩次點擊。",
	["Lock Frames"] = "鎖定框架",
	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "鎖定buff和debuff框架,隱藏背景防止被移動",

	["Cast by %s"] = "由 %s 施放",

--	["buff"] = "buff",
--	["debuff"] = "debuff",
	["Now ignoring buff: %s"] = "現在忽略的buff：%s",
	["Now ignoring debuff: %s"] = "現在忽略的debuff：%s",
	["No longer ignoring buff: %s"] = "不再忽略的buff：%s",
	["No longer ignoring debuff: %s"] = "不再忽略的debuff：%s",
	["No buffs are being ignored."] = "沒有被忽略的buffs。",
	["No debuffs are being ignored."] = "沒有被忽略的debuffs。",
	["%d |4buff:buffs; |4is:are; being ignored:"] = "%d |4buff:buffs;被忽略：",
	["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d |4debuff:debuffs;被忽略：",

}