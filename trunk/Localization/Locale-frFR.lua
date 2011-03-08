--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
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

	["Anesthetic Poison"] = "Poison anesthésiant", -- Removed in Cataclysm
	["Crippling Poison"] = "Poison affaiblissant",
	["Deadly Poison"] = "Poison mortel",
	["Instant Poison"] = "Poison instantané",
	["Mind-Numbing Poison"] = "Poison de [Dd]istraction mentale", -- item name has lowercase d
	["Wound Poison"] = "Poison douloureux",

-- Warlock weapon enchant keywords

	["Firestone"] = "Pierre de feu", -- Removed in Cataclysm
	["Spellstone"] = "Pierre de sort", -- Removed in Cataclysm

-- Configuration panel

	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Utilisez cette fenêtre pour ajuster des réglages basiques pour les icônes de buffs, debuffs, et buffs d'arme.",
	["Buff Size"] = "Taille des Buffs",
	["Adjust the size of each buff icon."] = "Configure la taille de chaque icône de buff.",
	["Buff Columns"] = "Colonnes de Buffs",
	["Adjust the number of buff icons to show on each row."] = "Configure le nombre d'icônes de Buffs à afficher par ligne.",
	["Debuff Size"] = "Taille des Debuffs",
	["Adjust the size of each debuff icon."] = "Configure la taille de chaque icône de debuff.",
	["Debuff Columns"] = "Colonnes de Debuffs",
	["Adjust the number of debuff icons to show on each row."] = "Configure le nombre d'icônes de Debuffs à afficher par ligne.",
	["Icon Spacing"] = "Espacement des Icônes",
	["Adjust the space between icons."] = "Configure l'espacement entre les icônes.",
	["Growth Anchor"] = "Ancrage de Propagation",
	["Set the side of the screen from which buffs and debuffs grow."] = "Configure le côté de l'écran à partir duquel les buffs et débuffs apparaîtront.",
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