--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
------------------------------------------------------------------------
	Russian Localization (Русский)
	Last updated YYYY-MM-DD by YourName
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "Жизнь Земли",
	["Flametongue"] = "Язык пламени",
	["Frostbrand"] = "Ледяное клеймо",
	["Rockbiter"] = "Камнедробителя", -- needs check
	["Windfury"] = "Неистовство ветра",

-- Rogue weapon enchant keywords

	["Anesthetic Poison"] = "Анестезирующий яд",
	["Crippling Poison"] = "Калечащий яд",
	["Deadly Poison"] = "Смертельный яд",
	["Instant Poison"] = "Быстродействующий яд",
	["Mind-Numbing Poison"] = "Дурманящий яд",
	["Wound Poison"] = "Нейтрализующий яд",

-- Warlock weapon enchant keywords

	["Firestone"] = "камень огня",
	["Spellstone"] = "камень чар",

-- Configuration panel

--	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "",
	["Buff Size"] = "Размер пол. эффектов",
	["Adjust the size of each buff icon."] = "Настроить размера значков положительного эффекта.",
	["Buff Columns"] = "Столбцов пол. эффектов",
	["Adjust the number of buff icons to show on each row."] = "Настроить числа положительный эффект значков для отображения на каждой строке.",
	["Debuff Size"] = "Размер отр. эффектов",
	["Adjust the size of each debuff icon."] = "Настроить размера значков отрицательного эффекта.",
	["Debuff Columns"] = "Столбцов отр. эффектов",
	["Adjust the number of debuff icons to show on each row."] = "Настроить числа отрицательных эффекта значков для отображения на каждой строке.",
	["Icon Spacing"] = "Иконка расстоянии",
	["Adjust the space between icons."] = "Настроить расстояния между иконками.",
	["Growth Anchor"] = "Иконка привязанности",
	["Set the side of the screen from which buffs and debuffs grow."] = "Установить какой стороне экрана значки привязан.",
	["Left"] = "Слева",
	["Right"] = "Справа",
	["Typeface"] = "Шрифт",
--	["Set the typeface for the stack count and timer text."] = "",
	["Text Outline"] = "Контур шрифта",
	["Set the outline weight for the stack count and timer text."] = "Настроить контура шрифта.",
	["None"] = "Нету",
	["Thin"] = "Тонкий",
	["Thick"] = "Толстый",
	["Text Size"] = "Размер шрифта",
	["Adjust the size of the stack count and timer text."] = "Настроить размера шрифта.",
--	["Max Timer Duration"] = "",
--	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "",
--	["Buff Sources"] = "",
--	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "",
--	["Weapon Buff Sources"] = "",
--	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "",
	["Lock Frames"] = "Закрепить значки",
--	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "",

	["Cast by %s"] = "Наносится %s",

	["Now ignoring buff: %s"] = "Теперь игнорируя положительный эффект: %s",
	["Now ignoring debuff: %s"] = "Теперь игнорируя отрицательный эффект: %s",
	["No longer ignoring buff: %s"] = "Больше не игнорируя положительный эффект: %s",
	["No longer ignoring debuff: %s"] = "Больше не игнорируя отрицательный эффект: %s",
	["No buffs are being ignored."] = "Вы не игнорируя любые положительные эффекты.",
	["No debuffs are being ignored."] = "Вы не игнорируя любые отрицательные эффекты",
	["%d |4buff:buffs; |4is:are; being ignored:"] = "Вы игнорируете %d |4положительный:положительных; |4эффект:эффектов;.",
	["%d |4debuff:debuffs; |4is:are; being ignored:"] = "Вы игнорируете %d |4отрицательный:отрицательных; |4эффект:эффектов;.",

}