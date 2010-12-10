--[[--------------------------------------------------------------------
PhanxBuffs
Replacement player buff, debuff, and temporary enchant frames.

http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx

Copyright © 2010 Phanx < addons@phanx.net >

I, the copyright holder of this work, hereby release it into the public
domain. This applies worldwide. In case this is not legally possible:
I grant anyone the right to use this work for any purpose, without any
conditions, unless such conditions are required by law.
------------------------------------------------------------------------
	French Localization (Français)
	Last updated 2010-10-26 by Strigx
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "Viveterre"
L["Flametongue"] = "Langue de feu"
L["Frostbrand"] = "Arme de givre"
L["Rockbiter"] = "Croque-roc"
L["Windfury"] = "Furie-des-vents"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "Poison anesthésiant"
L["Crippling Poison"] = "Poison affaiblissant"
L["Deadly Poison"] = "Poison mortel"
L["Instant Poison"] = "Poison instantané"
L["Mind-Numbing Poison"] = "Poison de [Dd]istraction mentale" -- item name has lowercase d
L["Wound Poison"] = "Poison douloureux"

-- Warlock weapon enchant keywords

L["Firestone"] = "Pierre de feu"
L["Spellstone"] = "Pierre de sort"

-- Configuration panel

L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Utilisez cette fenêtre pour ajuster des réglages basiques pour les icônes de buffs, debuffs, et buffs d'arme."
L["Buff Size"] = "Taille des Buffs"
L["Set the size of each buff icon."] = "Configure la taille de chaque icône de buff."
L["Buff Spacing"] = "Espacement des Buffs"
L["Set the space between buff icons."] = "Configure l'espacement entre les icônes de buff."
L["Buff Columns"] = "Colonnes de Buffs"
L["Set the number of buff icons to show on each row."] = "Configure le nombre d'icônes de Buffs à afficher par ligne."
L["Debuff Size"] = "Taille des Debuffs"
L["Set the size of each debuff icon."] = "Configure la taille de chaque icône de debuff."
L["Debuff Spacing"] = "Espacement des Debuffs"
L["Set the space between debuff icons."] = "Configure l'espacement entre les icônes de debuff."
L["Debuff Columns"] = "Colonnes de Debuffs"
L["Set the number of debuff icons to show on each row."] = "Configure le nombre d'icônes de Debuffs à afficher par ligne."
L["Typeface"] = "Police"
L["Set the typeface for stack count and timer text."] = "Configure la police de texte des compteurs de stack et du timer"
L["Text Outline"] = "Contour du Texte"
L["Set the outline weight for stack count and timer text."] = "Configure l'épaisseur du contour des textes de stack et timer."
L["None"] = "Aucun"
L["Thin"] = "Fin"
L["Thick"] = "Epais"
L["Growth Anchor"] = "Ancrage de Propagation"
L["Set the side of the screen from which buffs and debuffs grow."] = "Configure le côté de l'écran à partir duquel les buffs et débuffs apparaîtront."
L["Left"] = "Gauche"
L["Right"] = "Droite"
L["Buff Sources"] = "Origines des Buffs"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Affiche dans le tooltip du buff le nom du membre du groupe ou raid qui l'a incanté."
L["Weapon Buff Sources"] = "Origine des Buffs d'Arme"
L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "Affiche les Buffs d'Arme en tant que sort buffé par l'arme, et non comme l'Arme elle-même."
L["Lock Frames"] = "Verrouiller les cadres"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Verrouille les cadres de Buffs et Debuffs, masquant le fond et empechant de les déplacer."

L["Cast by %s"] = "Incanté par %s"

L["Now ignoring buff: %s."] = "Buff à présent ignoré : %s."
L["No longer ignoring buff: %s."] = "Buff n'étant à présent plus ignoré : %s."
L["Now ignoring debuff: %s."] = "Debuff à présent ignoré : %s"
L["No longer ignoring debuff: %s."] = "Debuff n'étant à présent plus ignoré : %s."
L["No buffs are being ignored:"] = "Aucun buffs sont ignorés."
L["%d buffs are being ignored:"] = "%d buffs actuellement ignorés:"
L["No debuffs are being ignored:"] = "Aucun debuffs sont ignorés."
L["%d debuffs are being ignored:"] = "%d debuffs actuellement ignorés:"