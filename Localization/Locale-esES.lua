--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
------------------------------------------------------------------------
	Spanish Localization (Español - Europa y América Latina)
	Last updated 2011-03-07 by Akkorian
----------------------------------------------------------------------]]

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "Vida terrestre",
	["Flametongue"] = "Lengua de Fuego",
	["Frostbrand"] = "Estigma de Escarcha",
	["Rockbiter"] = "Muerdepiedras",
	["Windfury"] = "Viento Furioso",

-- Rogue weapon enchant keywords

	["Crippling Poison"] = "Veneno entorpecedor",
	["Deadly Poison"] = "Veneno mortal",
	["Instant Poison"] = "Veneno instantáneo",
	["Mind-Numbing Poison"] = "Veneno de aturdimiento mental",
	["Wound Poison"] = "Veneno hiriente",

-- Configuration panel text

	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Estes opciones te permiten configurar los iconos de beneficios, perjuicios, y beneficios de armas.",
	["Buff Size"] = "Tamaño de beneficios",
	["Adjust the size of each buff icon."] = "Ajustar el tamaño de los iconos de beneficios.",
	["Buff Columns"] = "Columnas de beneficios",
	["Adjust the number of buff icons to show on each row."] = "Ajustar el número de iconos de beneficios para mostrar en cada fila.",
	["Debuff Size"] = "Tamaño de perjuicios",
	["Adjust the size of each debuff icon."] = "Ajustar el tamaño de los icons de perjuicios.",
	["Debuff Columns"] = "Columnas de perjuicios",
	["Adjust the number of debuff icons to show on each row."] = "Ajustar el número de iconos de perjuicios para mostrar en cada fila.",
	["Icon Spacing"] = "Espaciamiento de iconos",
	["Adjust the space between icons."] = "Ajustar el espaciamiento entre los iconos.",
	["Growth Anchor"] = "Ancla de iconos",
	["Set the side of the screen from which buffs and debuffs grow."] = "Establecer el lado de la pantalla para que anclar los iconos de beneficios y perjuicios.",
	["Left"] = "Izquierda",
	["Right"] = "Derecha",
	["Typeface"] = "Tipo de letra",
	["Set the typeface for the stack count and timer text."] = "Establecer el tipo de letra del texto de aplicaciones y tiempo.",
	["Text Outline"] = "Perfil de texto",
	["Set the outline weight for the stack count and timer text."] = "Establecer el grueso del perfil del texto de aplicaciones y tiempo.",
	["None"] = "Ninguno",
	["Thin"] = "Fino",
	["Thick"] = "Grueso",
	["Text Size"] = "Tamaño de texto",
	["Adjust the size of the stack count and timer text."] = "Ajustar el tamaño del texto de aplicaciones y tiempo.",
	["Max Timer Duration"] = "Tiempo máximo",
	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "Ajustar el máximo de tiempo restante, en segundos, para mostrar el texto de tiempo.",
	["Buff Casters"] = "Taumaturgos de beneficios",
	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Mostrar el nombre del miembro del grupo o banda que ha aplicado un beneficio a te en su descripción.",
	["Weapon Buff Sources"] = "Fuentes de encantamientos",
	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "Mostrar los beneficios del arma como el encanto o el artículo que encantaron el arma, en vez del arma sí mismo.",
	["Lock Frames"] = "Bloquear iconos",
	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Bloquear las iconos de beneficios y perjuicios, para ocultar el fondo y prevenir el movimiento.",

	["Cast by %s"] = "Aplicada por %s",

	["Now ignoring buff: %s"] = "Estás ignorando al beneficio: %s",
	["Now ignoring debuff: %s"] = "Estás ignorando al perjuicio: %s",
	["No longer ignoring buff: %s"] = "Ya no estás ignorando al beneficio: %s",
	["No longer ignoring debuff: %s"] = "Ya no estás ignorando al perjucio: %s",
	["No buffs are being ignored."] = "No estás ignorando a ningún beneficios.",
	["No debuffs are being ignored."] = "No estás ignorando a ningún perjuicios.",
	["%d |4buff:buffs; |4is:are; being ignored:"] = "Estás ignorando a %d |4beneficio:beneficios;:",
	["%d |4debuff:debuffs; |4is:are; being ignored:"] = "Estás ignorando a %d |perjuicio:perjuicios;:",

}