--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
------------------------------------------------------------------------
	French Localization (Français)
	Last updated 2010-10-26 by Strigx
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "Viveterre",
	["Flametongue"] = "Langue de feu",
	["Frostbrand"] = "Arme de givre",
	["Rockbiter"] = "Croque-roc",
	["Windfury"] = "Furie-des-vents",

-- Rogue weapon enchant keywords

	["Crippling Poison"] = "Poison affaiblissant",
	["Deadly Poison"] = "Poison mortel",
--	["Leeching Poison"] = "",
	["Mind-Numbing Poison"] = "Poison de [Dd]istraction mentale", -- item name has lowercase d
--	["Paralytic Poison"] = "",
	["Wound Poison"] = "Poison douloureux",

-- Configuration panel

	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Utilisez cette fenêtre pour ajuster des réglages basiques pour les icônes de buffs, debuffs, et buffs d'arme.",
	["Buff Size"] = "Taille des Buffs",
	["Adjust the size of each buff icon."] = "Configure la taille de chaque icône de buff.",
	["Buff Spacing"] = "Espacement des Buffs",
	["Adjust the space between buff icons."] = "Configure l'espacement entre les icônes des buffs.",
	["Buff Columns"] = "Colonnes de Buffs",
	["Adjust the number of buff icons to show on each row."] = "Configure le nombre d'icônes de Buffs à afficher par ligne.",
	["Buff Anchor"] = "Ancrage des Buffs",
--	["Choose whether the buff icons grow from left to right, or right to left."] = "",
--	["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "",

	["Debuff Size"] = "Taille des Debuffs",
	["Adjust the size of each debuff icon."] = "Configure la taille de chaque icône de debuff.",
	["Debuff Spacing"] = "Espacement des Debuffs",
	["Adjust the space between debuff icons."] = "Configure l'espacement entre les icônes des debuffs.",
	["Debuff Columns"] = "Colonnes de Debuffs",
	["Adjust the number of debuff icons to show on each row."] = "Configure le nombre d'icônes de Debuffs à afficher par ligne.",
	["Debuff Anchor"] = "Ancrage des Debuffs",
--	["Choose whether the debuff icons grow from left to right, or right to left."] = "",
--	["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "",

--	["Top"] = "",
--	["Bottom"] = "",
	["Left"] = "Gauche",
	["Right"] = "Droite",

	["Typeface"] = "Police",
	["Set the typeface for the stack count and timer text."] = "Configure la police de texte des compteurs de stack et du timer.",
	["Text Outline"] = "Contour du Texte",
	["Set the outline weight for the stack count and timer text."] = "Configure l'épaisseur du contour des textes de stack et timer.",
	["None"] = "Aucun",
	["Thin"] = "Fin",
	["Thick"] = "Epais",
--	["Text Size"] = "",
--	["Adjust the size of the stack count and timer text."] = "",

--	["Max Timer Duration"] = "",
--	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "",

	["Buff Sources"] = "Origines des Buffs",
	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Affiche dans le tooltip du buff le nom du membre du groupe ou raid qui l'a incanté.",
	["Weapon Buff Sources"] = "Origine des Buffs d'Arme",
	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "Affiche les Buffs d'Arme en tant que sort buffé par l'arme, et non comme l'Arme elle-même.",
--	["One-Click Cancel"] = "",
--	["Cancel unprotected buffs on the first click, instead of the second. Only works out of combat, and protected buffs like shapeshift forms and weapon buffs will still require two clicks."] = "",
	["Lock Frames"] = "Verrouiller les cadres",
	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Verrouille les cadres de Buffs et Debuffs, masquant le fond et empechant de les déplacer.",

	["Cast by %s"] = "Incanté par %s",

	["Now ignoring buff: %s"] = "Buff à présent ignoré : %s",
	["Now ignoring debuff: %s"] = "Debuff à présent ignoré : %s",
	["No longer ignoring buff: %s"] = "Buff n'étant à présent plus ignoré : %s",
	["No longer ignoring debuff: %s"] = "Debuff n'étant à présent plus ignoré : %s",
	["No buffs are being ignored."] = "Aucun buffs sont ignorés.",
	["No debuffs are being ignored."] = "%d buffs actuellement ignorés :",
	["%d |4buff:buffs; |4is:are; being ignored:"] = "Aucun debuffs sont ignorés.",
	["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d debuffs actuellement ignorés :",

}