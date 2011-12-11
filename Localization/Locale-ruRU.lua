--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
------------------------------------------------------------------------
	Russian Localization (Русский)
	Last updated 2011-03-14 by Akkorian
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "[Жж]изн[ьи] [Зз]емли",
	["Flametongue"] = "[Яя]зыка? пламени",
	["Frostbrand"] = "[Лл]едяно[ег]о? клейм[оа]",
	["Rockbiter"] = "[Кк]амнедробител[яь]",
	["Windfury"] = "[Нн]еистовств[ао] ветра",

-- Rogue weapon enchant keywords

	["Crippling Poison"] = "Калечащий яд",
	["Deadly Poison"] = "Смертельный яд",
	["Instant Poison"] = "Быстродействующий яд",
	["Mind-Numbing Poison"] = "Дурманящий яд",
	["Wound Poison"] = "Нейтрализующий яд",

-- Configuration panel

	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Эти настройки позволяют настроить значков для положительных и отрицательных эффектов, и чар, связанных с оружием.",
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
	["Set the typeface for the stack count and timer text."] = "Настроить шрифт для имя и заряд счетчиков.",
	["Text Outline"] = "Контур шрифта",
	["Set the outline weight for the stack count and timer text."] = "Настроить контура шрифта.",
	["None"] = "Нету",
	["Thin"] = "Тонкий",
	["Thick"] = "Толстый",
	["Text Size"] = "Размер шрифта",
	["Adjust the size of the stack count and timer text."] = "Настроить размера шрифта.",
	["Max Timer Duration"] = "Максимальное время",
	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "Установите максимальное количество времени в секундах, чтобы показать отметчик времени для эффект.",
	["Buff Sources"] = "Источники эффекты",
	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Показать имя персонажа который наложил положительный эффект на вас во всплывающих подсказках.",
	["Weapon Buff Sources"] = "Источники чарами",
	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "Отображать чары, связанных с оружием, а не оружия.",
	["Lock Frames"] = "Заблокировать значки",
	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Заблокировать значки, предотвращение перемещения и скрытия фона.",

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