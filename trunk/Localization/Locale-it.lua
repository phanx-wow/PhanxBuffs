--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
------------------------------------------------------------------------
	Italian Localization (Italiano)
	Last updated 2014-04-11 by Phanx
----------------------------------------------------------------------]]

if GetLocale() ~= "itIT" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "Terra Benefica",
	["Flametongue"] = "Lingua di Fuoco",
	["Frostbrand"] = "Marchio del Gelo",
	["Rockbiter"] = "Roccia Dura",
	["Windfury"] = "Furia del Vento",

-- Rogue weapon enchant keywords

--	["Crippling Poison"] = "Crippling Poison",
--	["Deadly Poison"] = "Deadly Poison",
--	["Leeching Poison"] = "Leeching Poison",
--	["Mind-Numbing Poison"] = "Mind-Numbing Poison",
--	["Paralytic Poison"] = "Paralytic Poison",
--	["Wound Poison"] = "Wound Poison",

-- Fake buff tooltip text

	[105361] = "Danni da sacro inflitti dagli attacchi in mischia.", -- Sigillo di Comando
	[20165] = "Velocità di lancio d'incantesimi aumentata del 10%.\nCure fornite aumentate del 5%.\nGli attacchi in mischia hanno una probabilità di curare.", -- Sigillo della Consapevolezza
	[20154] = "Gli attacchi in mischia infliggono danni da sacro contro tutti i bersagli entro 8 m.", -- Sigillo della Rettitudine
	[31801] = "Danni da sacro inflitti dagli attacchi in mischia in 15 s.", -- Sigillo della Verità

-- Configuration panel

--	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons.",

	["Buff Size"] = "Dimensione di benefici",
--	["Adjust the size of each buff icon."] = "Adjust the size of each buff icon.",
	["Buff Spacing"] = "Spaziatura di benefici",
--	["Adjust the space between buff icons."] = "Adjust the space between buff icons.",
	["Buff Columns"] = "Colonne di benefici",
--	["Adjust the number of buff icons to show on each row."] = "Adjust the number of buff icons to show on each row.",
	["Buff Anchor"] = "Ancoraggio di benefici",
--	["Choose whether the buff icons grow from left to right, or right to left."] = "Choose whether the buff icons grow from left to right, or right to left.",
--	["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "Choose whether the buff icons grow from top to bottom, or bottom to top.",

	["Debuff Size"] = "Dimensioni di malefici",
--	["Adjust the size of each debuff icon."] = "Adjust the size of each debuff icon.",
	["Debuff Spacing"] = "Spaziatura di malefici",
--	["Adjust the space between debuff icons."] = "Adjust the space between debuff icons.",
	["Debuff Columns"] = "Colonne di malefici",
--	["Adjust the number of debuff icons to show on each row."] = "Adjust the number of debuff icons to show on each row.",
	["Debuff Anchor"] = "Ancoraggio di malefici",
--	["Choose whether the debuff icons grow from left to right, or right to left."] = "Choose whether the debuff icons grow from left to right, or right to left.",
--	["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "Choose whether the debuff icons grow from top to bottom, or bottom to top.",

	["Top"] = "Alto",
	["Bottom"] = "Basso",
	["Left"] = "Sinistra",
	["Right"] = "Destra",

	["Typeface"] = "Tipo di carattere",
--	["Set the typeface for the stack count and timer text."] = "Set the typeface for the stack count and timer text.",
	["Text Outline"] = "Contorno di carattere",
--	["Set the outline weight for the stack count and timer text."] = "Set the outline weight for the stack count and timer text.",
	["None"] = "Nessuno",
	["Thin"] = "Sottile",
	["Thick"] = "Spesso",
	["Text Size"] = "Dimensione di carattere",
--	["Adjust the size of the stack count and timer text."] = "Adjust the size of the stack count and timer text.",

	["Max Timer Duration"] = "Durata massima per testo",
--	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff.",

--	["Show stance icons"] = "",
--	["Show fake buff icons for warrior stances and paladin seals."] = "",
	["Buff Sources"] = "Origini di benefici",
--	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Show the name of the party or raid member who cast a buff on you in its tooltip.",
	["Weapon Buff Sources"] = "Origini di incantamenti di armi",
--	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself.",
	["One-Click Cancel"] = "Rimuovi con un click",
--	["Cancel unprotected buffs on the first click, instead of the second. Only works out of combat, and protected buffs like shapeshift forms and weapon buffs will still require two clicks."] = "Cancel unprotected buffs on the first click, instead of the second. Only works out of combat, and protected buffs like shapeshift forms and weapon buffs will still require two clicks.",
	["Lock Frames"] = "Blocca icone",
--	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved.",

	["Cast by %s"] = "Lanciato da %s",

	["buff"] = "beneficio",
	["debuff"] = "maleficio",
	["Now ignoring buff: %s"] = "Ora ignorando il beneficio: %s",
	["Now ignoring debuff: %s"] = "Ora ignorando il maleficio: %s",
	["No longer ignoring buff: %s"] = "Non più ignorando il beneficio: %s",
	["No longer ignoring debuff: %s"] = "Non più ignorando il maleficio: %s",
	["No buffs are being ignored."] = "Nessun benefici vengono ignorati.",
	["No debuffs are being ignored."] = "Nessun malefici vengono ignorati.",
	["%d |4buff:buffs; |4is:are; being ignored:"] = "%d |4beneficio viene ignorato:benefici vengono ignorati;:",
	["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d |4maleficio viene ignorato:malefici vengono ignorati;:",

}