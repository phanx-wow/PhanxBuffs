--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
------------------------------------------------------------------------
	Korean Localization (한국어)
	Last updated 2010-09-07 by Bruteforce
----------------------------------------------------------------------]]

if GetLocale() ~= "koKR" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "대지생명의 무기"
L["Flametongue"] = "불꽃의 무기"
L["Frostbrand"] = "냉기의 무기"
-- L["Rockbiter"] = ""
L["Windfury"] = "질풍의 무기"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "정신 마취 독"
L["Crippling Poison"] = "신경 마비 독"
L["Deadly Poison"] = "맹독"
L["Instant Poison"] = "순간 효과 독"
L["Mind-Numbing Poison"] = "정신 마비 독"
L["Wound Poison"] = "상처 감염 독"

-- Warlock weapon enchant keywords

L["Firestone"] = "화염석"
L["Spellstone"] = "주문석"

-- Configuration panel

L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "이 패널을 이용해서 버프, 디버프 그리고 무기 버프 아이콘을 위해 약간의 간단한 설정을 조정하세요."
L["Buff Size"] = "버프 크기"
L["Set the size of each buff icon."] = "각각의 버프 아이콘 크기를 설정합니다."
L["Buff Spacing"] = "버프 간격"
L["Set the space between buff icons."] = "버프 아이콘 사이의 공간을 설정합니다."
L["Buff Columns"] = "버프 열"
L["Set the number of buff icons to show on each row."] = "각각의 행에 보여질 버프 아이콘의 갯수를 설정합니다."
L["Debuff Size"] = "디버프 크기"
L["Set the size of each debuff icon."] = "각각의 디버프 아이콘 크기를 설정합니다."
L["Debuff Spacing"] = "디버프 간격"
L["Set the space between debuff icons."] = "디버프 아이콘 사이의 공간을 설정합니다."
L["Debuff Columns"] = "디버프 열"
L["Set the number of debuff icons to show on each row."] = "각각의 행에 보여질 디버프 아이콘의 갯수를 설정합니다."
L["Typeface"] = "글꼴"
L["Set the typeface for stack count and timer text."] = "중첩 카운트와 타이머 텍스트를 위해 글꼴을 설정합니다."
L["Text Outline"] = "텍스트 외곽선"
L["Set the outline weight for stack count and timer text."] = "중첩 카운트와 타이머 텍스트를 위해 외곽선 두께를 설정합니다."
L["None"] = "없음"
L["Thin"] = "얇게"
L["Thick"] = "두껍게"
L["Growth Anchor"] = "성장 기준점"
L["Set the side of the screen from which buffs and debuffs grow."] = "버프와 디버프가 성장할 화면의 측면을 설정합니다."
L["Left"] = "왼쪽"
L["Right"] = "오른쪽"
L["Buff Sources"] = "버프 출처"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "파티원 또는 공격대원 중 당신에게 버프를 시전한 누군가의 이름을 툴팁에 보여줍니다."
L["Weapon Buff Sources"] = "무기 버프 출처"
L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "무기 자체를 대신하는 주문에 의한 무기 버프 또는 아이템에 의해 버프된 무기를 보여줍니다."
L["Lock Frames"] = "프레임 잠금"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "해당 위치에 버프와 디버프 프레임을 잠급니다. 배경을 숨기고 움직이지 못하도록 합니다."

L["Cast by %s"] = "시전자: %s"

-- L["Now ignoring buff: %s."] = ""
-- L["No longer ignoring buff: %s."] = ""
-- L["Now ignoring debuff: %s."] = ""
-- L["No longer ignoring debuff: %s."] = ""
-- L["No buffs are being ignored:"] = ""
-- L["%d buffs are being ignored:"] = ""
-- L["No debuffs are being ignored:"] = ""
-- L["%d debuffs are being ignored:"] = ""