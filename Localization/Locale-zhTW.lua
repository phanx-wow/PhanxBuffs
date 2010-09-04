--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
------------------------------------------------------------------------
	Traditional Chinese Localization (正體中文)
	Last updated 2010-07-20 by fmdsm on curse.com
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "大地生命"
L["Flametongue"] = "火舌"
L["Frostbrand"] = "冰封"
-- L["Rockbiter"] = ""
L["Windfury"] = "風怒"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "麻醉"
L["Crippling Poison"] = "致殘"
L["Deadly Poison"] = "致命"
L["Instant Poison"] = "速效"
L["Mind-Numbing Poison"] = "麻痹"
L["Wound Poison"] = "致傷"

-- Warlock weapon enchant keywords

L["Firestone"] = "火焰石"
L["Spellstone"] = "法術石"

-- Configuration panel

L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "這裡可以調整buff,debuff,武器附魔圖示的基本設置."
L["Buff Size"] = "buff大小"
L["Set the size of each buff icon."] = "設置buff圖示大小"
L["Buff Spacing"] = "buff間距"
L["Set the space between buff icons."] = "設置buff圖示間距"
L["Buff Columns"] = "buff列數"
L["Set the number of buff icons to show on each row."] = "設置buff圖示每行顯示的個數"
L["Debuff Size"] = "debuff大小"
L["Set the size of each debuff icon."] = "設置debuff圖示大小"
L["Debuff Spacing"] = "debuff間距"
L["Set the space between debuff icons."] = "設置debuff圖示間距"
L["Debuff Columns"] = "debuff列數"
L["Set the number of debuff icons to show on each row."] = "設置debuff圖示每行顯示的個數"
L["Typeface"] = "字型"
L["Set the typeface for stack count and timer text."] = "設置層數和時間文字字型"
L["Text Outline"] = "文本輪廓"
L["Set the outline weight for stack count and timer text."] = "設置層數和時間文字輪廓"
L["None"] = "無"
L["Thin"] = "細"
L["Thick"] = "粗"
L["Growth Anchor"] = "描點對齊"
L["Set the side of the screen from which buffs and debuffs grow."] = "設置buff和debuff從屏幕哪邊對齊."
L["Left"] = "左"
L["Right"] = "右"
L["Buff Sources"] = "buff來源"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "在提示上顯示buff施放者的名字."
L["Weapon Buff Sources"] = "武器附魔來源"
L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "顯示武器附魔圖示用附魔物品或法術來取代武器本身."
L["Lock Frames"] = "鎖定框架"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "鎖定buff和debuff框架,隱藏背景防止被移動."

-- L["These buffs are currently being ignored:"] = ""
-- L["These debuffs are currently being ignored:"] = ""
