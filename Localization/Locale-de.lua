--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
------------------------------------------------------------------------
	German Localization (Deutsch)
	Last updated 2013-12-18 by Phanx
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "Lebensgeister",
	["Flametongue"] = "Flammenzunge",
	["Frostbrand"] = "Frostbrand",
	["Rockbiter"] = "Felsbeißer",
	["Windfury"] = "Windzorn",

-- Rogue weapon enchant keywords

	["Crippling Poison"] = "Verkrüppel[nu][dn][eg]s%s?[Gg]ift", -- item is Verkrüppelndes Gift, enchant is Verkrüppelungsgift
	["Deadly Poison"] = "Tödliches Gift",
	["Leeching Poison"] = "Egelgift",
	["Mind-Numbing Poison"] = "Gedankenbenebelndes Gift",
	["Paralytic Poison"] = "Betäubendes Gift",
	["Wound Poison"] = "Wundgift",

-- Fake buff tooltip text

	[105361] = "Nahkampfangriffe verursachen Heiligschaden.", -- Siegel des Befehls
	[20165] = "Zaubertempo um 10% erhöht.\nGewirkte Heilung um 5% erhöht.\nNahkampfangriffe haben eine Chance, Heilung hervorzurufen.", -- Siegel der Einsicht
	[20154] = "Nahkampfangriffe fügen allen Zielen im Umkreis von 8 Metern Heiligschaden zu.", -- Siegel der Rechtschaffenheit
	[31801] = "Nahkampfangriffe verursachen im Verlauf von 15 Sek. Heiligschaden.", -- Siegel der Wahrheit

-- Configuration panel

	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Mit diesen Optionen könnt Ihr die Stärkungszauber-, Schwächungszauber- und Waffenverzauberungssymbole dieses Addon konfigurieren.",

	["Buff Size"] = "Stärkungszaubergröße",
	["Adjust the size of each buff icon."] = "Die Größe jedes Stärkungszaubersymbol ändern.",
	["Buff Spacing"] = "Stärkungszauberabstand",
	["Adjust the space between buff icons."] = "Der Abstand zwischen den Stärkungszaubersymbolen ändern.",
	["Buff Columns"] = "Stärkungszauberspalten",
	["Adjust the number of buff icons to show on each row."] = "Die Anzahl der Stärkungszaubersymbole ändern, die auf jeder Zeile anzeigen.",
	["Buff Anchor"] = "Ankerpunkt der Stärkungszaubers",
	["Choose whether the buff icons grow from left to right, or right to left."] = "Wählen, ob die Stärkungszaubersymbole von links nach rechts oder von rechts nach links wachsen.",
	["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "Wählen, ob die Stärkungszaubersymbole von oben nach unten order von unten nach oben wachsen.",

	["Debuff Size"] = "Schwächungszaubergröße",
	["Adjust the size of each debuff icon."] = "Die Größe jedes Schwächungszaubersymbol ändern.",
	["Debuff Spacing"] = "Schwächungszauberabstand",
	["Adjust the space between debuff icons."] = "Der Abstand zwischen den Schwächungszaubersymbolen ändern.",
	["Debuff Columns"] = "Schwächungszauberspalten",
	["Adjust the number of debuff icons to show on each row."] = "Die Anzahl der Schwächungszaubersymbole ändern, die auf jeder Zeile anzeigen.",
	["Debuff Anchor"] = "Ankerpunkt der Schwächungszaubers",
	["Choose whether the debuff icons grow from left to right, or right to left."] = "Wählen, ob die Schwächungszaubersymbole von links nach rechts oder von rechts nach links wachsen.",
	["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "Wählen, ob die Schwächungszaubersymbole von oben nach unten order von unten nach oben wachsen.",

	["Top"] = "Oben",
	["Bottom"] = "Unten",
	["Left"] = "Links",
	["Right"] = "Rechts",

	["Typeface"] = "Schriftart",
	["Set the typeface for the stack count and timer text."] = "Die Schriftart des Zahlen- und Timertext wählen.",
	["Text Outline"] = "Schriftumriss",
	["Set the outline weight for the stack count and timer text."] = "Den Schriftumriss des Zahlen- und Timertext wählen.",
	["None"] = "Keiner",
	["Thin"] = "Dünn",
	["Thick"] = "Dick",
	["Text Size"] = "Schriftgröße",
	["Adjust the size of the stack count and timer text."] = "Die Größe des Zahlen- und Timertext anpassen.",

	["Max Timer Duration"] = "Höchstdauer",
	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "Die maximale Dauer in Sekunden anpassen, um den Timertext einer Stärkungs- oder Schwächungszauber anzeigen.",

	["Show stance icons"] = "Haltungssymbole",
	["Show fake buff icons for monk and warrior stances and paladin seals."] = "Gefälschten Stärkungszaubersymbole für den Mönchs- und Kriegershaltungen und Paladinsiegel anzeigen.",
	["Buff Sources"] = "Stärkungszauberquellen",
	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Den Name des Gruppen- oder Schlachtzugsmitglied in Stärkungszaubertooltips anzeigen, das es auf euch gewirkt.",
	["Weapon Buff Sources"] = "Waffenverzauberungsquellen",
	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "Statt der Waffe den Zauber oder Gegenstand anziegen, der die Waffe verzaubern.",
	["One-Click Cancel"] = "Mit einem Klick abbrechen",
	["Cancel unprotected buffs on the first click, instead of the second. Only works out of combat, and protected buffs like shapeshift forms and weapon buffs will still require two clicks."] = "Stärkungszauber mit dem ersten Klick statt des zweiten abbrechen. Diese funktioniert nur außerhalb des Kampfes. Einige geschützten Zauber (zB Gestalten der Druiden und Waffenverzauberungen) noch benötigen zwei Klicks, um abzubrechen.",
	["Lock Frames"] = "Symbole fixieren",
	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Die Stärkungs- und Schwächungszauber-Symbole fixieren, um den Hintergrund zu verstecken und die Bewegung zu verhindern.", -- @PHANX: extra hyphen in Schwächungszaubersymbole because Blizz sucks at tooltip wrapping

	["Cast by %s"] = "Von %s aufgebracht",

	["buff"] = "stärkungszauber",
	["debuff"] = "schwächungszauber",
	["Now ignoring buff: %s"] = "Der Stärkungszauber '%s' wird jetzt ignoriert.",
	["Now ignoring debuff: %s"] = "Der Schwächungszauber '%s' wird jetzt ignoriert.",
	["No longer ignoring buff: %s"] = "Der Stärkungszauber '%s' wird nicht mehr ignoriert.",
	["No longer ignoring debuff: %s"] = "Der Schwächungszauber '%s' wird nicht mehr ignoriert.",
	["No buffs are being ignored."] = "Keine Stärkungszauber werden ignoriert.",
	["No debuffs are being ignored."] = "Keine Schwächungszauber werden ignoriert.",
	["%d |4buff:buffs; |4is:are; being ignored:"] = "%d Stärkungszauber werden ignoriert.",
	["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d Schwächungszauber werden ignoriert.",

}