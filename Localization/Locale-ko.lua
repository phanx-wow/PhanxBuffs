--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
------------------------------------------------------------------------
	Korean Localization (한국어)
	Last updated 2010-09-07 by Bruteforce
----------------------------------------------------------------------]]

if GetLocale() ~= "koKR" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "대지생명의 무기",
	["Flametongue"] = "불꽃의 무기",
	["Frostbrand"] = "냉기의 무기",
	["Rockbiter"] = "대지의 무기", -- Needs check
	["Windfury"] = "질풍의 무기",

-- Rogue weapon enchant keywords

	["Crippling Poison"] = "신경 마비 독",
	["Deadly Poison"] = "맹독",
--	["Leeching Poison"] = "",
	["Mind-Numbing Poison"] = "정신 마비 독",
--	["Paralytic Poison"] = "",
	["Wound Poison"] = "상처 감염 독",

-- Fake buff tooltip text

--	[105361] = "Melee attacks cause Holy damage.", -- Seal of Command
--	[20165] = "Improves casting speed by 10%.\nImproves healing by 5%.\nMelee attacks have a chance to heal.", -- Seal of Insight
--	[20154] = "Melee attacks cause Holy damage against all targets within 8 yards.", -- Seal of Righteousness
--	[31801] = "Melee attacks cause Holy damage over 15 sec.", -- Seal of Truth

-- Configuration panel

	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "이 패널을 이용해서 버프, 디버프 그리고 무기 버프 아이콘을 위해 약간의 간단한 설정을 조정하세요.",

	["Buff Size"] = "버프 크기",
	["Adjust the size of each buff icon."] = "각각의 버프 아이콘 크기를 설정합니다.",
	["Buff Spacing"] = "버프 간격",
	["Adjust the space between buff icons."] = "버프 아이콘 사이의 공간을 설정합니다.",
	["Buff Columns"] = "버프 열",
	["Adjust the number of buff icons to show on each row."] = "각각의 행에 보여질 버프 아이콘의 갯수를 설정합니다.",
	["Buff Anchor"] = "버프 성장 기준점",
--	["Choose whether the buff icons grow from left to right, or right to left."] = "",
--	["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "",

	["Debuff Size"] = "디버프 크기",
	["Adjust the size of each debuff icon."] = "디버프 아이콘 크기를 설정합니다.",
	["Debuff Spacing"] = "디버프 간격",
	["Adjust the space between debuff icons."] = "디버프 아이콘 사이의 공간을 설정합니다.",
	["Debuff Columns"] = "디버프 열",
	["Adjust the number of debuff icons to show on each row."] = "각각의 행에 보여질 디버프 아이콘의 갯수를 설정합니다.",
	["Debuff Anchor"] = "디버프 성장 기준점",
--	["Choose whether the debuff icons grow from left to right, or right to left."] = "",
--	["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "",

--	["Top"] = "",
--	["Bottom"] = "",
	["Left"] = "왼쪽",
	["Right"] = "오른쪽",

	["Typeface"] = "글꼴",
	["Set the typeface for the stack count and timer text."] = "중첩 카운트와 타이머 텍스트를 위해 글꼴을 설정합니다.",
	["Text Outline"] = "글꼴 외각선",
	["Set the outline weight for the stack count and timer text."] = "중첩 카운트와 타이머 텍스트를 위해 외곽선 두께를 설정합니다.",
	["None"] = "없음",
	["Thin"] = "얇게",
	["Thick"] = "두껍게",
	["Text Size"] = "글꼴 크기",
	["Adjust the size of the stack count and timer text."] = "중첩 카운트와 타이머 텍스트를 위해 글꼴 크기를 설정합니다.",

	["Max Timer Duration"] = "최대 시간",
	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "최대 시간, 초, 타이머를 표시합니다.",

--	["Show stance icons"] = "",
--	["Show fake buff icons for warrior stances and paladin seals."] = "",
	["Buff Sources"] = "버프 출처",
	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "파티원 또는 공격대원 중 당신에게 버프를 시전한 누군가의 이름을 툴팁에 보여줍니다.",
	["Weapon Buff Sources"] = "무기 버프 출처",
	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "무기 자체를 대신하는 주문에 의한 무기 버프 또는 아이템에 의해 버프된 무기를 보여줍니다.",
--	["One-Click Cancel"] = "",
--	["Cancel unprotected buffs on the first click, instead of the second. Only works out of combat, and protected buffs like shapeshift forms and weapon buffs will still require two clicks."] = "",
	["Lock Frames"] = "프레임 잠금",
	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "해당 위치에 버프와 디버프 프레임을 잠급니다. 배경을 숨기고 움직이지 못하도록 합니다.",

	["Cast by %s"] = "시전자: %s",

--	["buff"] = "buff",
--	["debuff"] = "debuff",
	["Now ignoring buff: %s"] = "버프 %s 님이 차단 목록에 등록되었습니다.",
	["Now ignoring debuff: %s"] = "디버프 %s 님이 차단 목록에 등록되었습니다.",
	["No longer ignoring buff: %s"] = "버프%s 님이 차단 목록에서 제외되었습니다.",
	["No longer ignoring debuff: %s"] = "디버프 %s 님이 차단 목록에서 제외되었습니다.",
	["No buffs are being ignored."] = "아니 디버프가 차단 목록에 있습니다.",
	["No debuffs are being ignored."] = "아니 버프가 차단 목록에 있습니다.",
	["%d |4buff:buffs; |4is:are; being ignored:"] = "%d 버프가 차단 목록에 있습니다:",
	["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d 디버프가 차단 목록에 있습니다:",

}