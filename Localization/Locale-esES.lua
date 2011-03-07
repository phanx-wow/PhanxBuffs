--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
------------------------------------------------------------------------
	Spanish Localization (Español (EU) y Español (AL))
	Last updated 2010-09-03 by Phanx
----------------------------------------------------------------------]]

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "Vida terrestre",
	["Flametongue"] = "Lengua de Fuego",
	["Frostbrand"] = "Estigma de Escarcha",
	["Rockbiter"] = "Muerdepiedras", -- needs check
	["Windfury"] = "Viento Furioso",

-- Rogue weapon enchant keywords

	["Anesthetic Poison"] = "Veneno anestésico",
	["Crippling Poison"] = "Veneno entorpecedor",
	["Deadly Poison"] = "Veneno mortal",
	["Instant Poison"] = "Veneno instantáneo",
	["Mind-Numbing Poison"] = "Veneno de aturdimiento mental",
	["Wound Poison"] = "Veneno hiriente",

-- Warlock weapon enchant keywords

	["Firestone"] = "Piedra de fuego",
	["Spellstone"] = "Piedra de hechizo",

-- Configuration panel text

	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Estes opciones te permiten configurar los iconos de beneficios, perjuicios, y beneficios de armas.",
	["Buff Size"] = "Tamaño de beneficios",
	["Set the size of each buff icon."] = "Ajustar el tamaño de cada icono de beneficio.",
	["Buff Spacing"] = "Espaciamiento de beneficios",
	["Set the space between buff icons."] = "Ajustar el espaciamiento entre los iconos de beneficios.",
	["Buff Columns"] = "Columnas de beneficios",
	["Set the number of buff icons to show on each row."] = "Ajustar el número de iconos de beneficios para mostrar en cada fila.",
	["Debuff Size"] = "Tamaño de perjuicios",
	["Set the size of each debuff icon."] = "Ajustar el tamaño de cada icono de perjuicio.",
	["Debuff Spacing"] = "Espaciamiento de perjuicios",
	["Set the space between debuff icons."] = "Ajustar el espaciamiento entre los iconos de perjuicios.",
	["Debuff Columns"] = "Columnas de perjuicios",
	["Set the number of debuff icons to show on each row."] = "Ajustar el número de iconos de perjuicios para mostrar en cada fila.",
	["Typeface"] = "Tipo de letra",
	["Set the typeface for stack count and timer text."] = "Establecer el tipo de letra del texto de aplicaciones y tiempo.",
	["Text Outline"] = "Perfil de texto",
	["Set the outline weight for stack count and timer text."] = "Establecer el grueso del perfil del texto de aplicaciones y tiempo.",
	["None"] = "Ninguno",
	["Thin"] = "Fino",
	["Thick"] = "Grueso",
	["Text Scale"] = "Tamaño de texto",
	["Adjust the size of the stack count and timer text."] = "Ajustar el tamaño del texto de aplicaciones y tiempo.",
	["Growth Anchor"] = "Ancla de iconos",
	["Set the side of the screen from which buffs and debuffs grow."] = "Establecer el lado de la pantalla para que anclar los iconos de beneficios y perjuicios.",
	["Left"] = "Izquierda",
	["Right"] = "Derecha",
	["Buff Sources"] = "Taumaturgos de beneficios",
	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Mostrar el nombre del miembro del grupo o banda que ha aplicado un beneficio en su descripción.",
	["Weapon Buff Sources"] = "Fuentes de encantamientos de arma",
	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "Mostrar los beneficios del arma como el encanto o el artículo que encantaron el arma, en vez del arma sí mismo.",
	["Lock Frames"] = "Bloquear iconos",
	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Bloquear las iconos de beneficios y perjuicios, para ocultar el fondo y prevenir el movimiento.",

	["Cast by %s"] = "Aplicada por %s",

	["Now ignoring buff: %s"] = "Estás ignorando beneficio: %s",
	["Now ignoring debuff: %s"] = "Estás ignorando perjuicio: %s",
	["No longer ignoring buff: %s"] = "Ya no estás ignorando beneficio: %s",
	["No longer ignoring debuff: %s"] = "Ya no estás ignorando perjucio: %s",
	["Currently ignoring these buffs:"] = "Estás ignorando estes beneficios:",
	["Currently ignoring these debuffs:"] = "Estás ignorando estes perjuicios:",
	["%d buffs are being ignored:"] = "Estás ignorando % beneficios:",
	["%d debuffs are being ignored:"] = "Estás ignorando % perjuicios:",
	["No buffs are being ignored:"] = "No estás ignorando cualquier beneficios.",
	["No debuffs are being ignored:"] = "No estás ignorando cualquier perjuicios.",

}