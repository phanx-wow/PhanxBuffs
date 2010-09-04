--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
------------------------------------------------------------------------
	Spanish Localization (Español (EU) y Español (AL))
	Last updated 2010-09-03 by Phanx
----------------------------------------------------------------------]]

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "Vida terrestre"
L["Flametongue"] = "Lengua de Fuego"
L["Frostbrand"] = "Estigma de Escarcha"
L["Rockbiter"] = "Muerdepiedras" -- needs check
L["Windfury"] = "Viento Furioso"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "Veneno anestésico"
L["Crippling Poison"] = "Veneno entorpecedor"
L["Deadly Poison"] = "Veneno mortal"
L["Instant Poison"] = "Veneno instantáneo"
L["Mind-Numbing Poison"] = "Veneno de aturdimiento mental"
L["Wound Poison"] = "Veneno hiriente"

-- Warlock weapon enchant keywords

L["Firestone"] = "Piedra de fuego"
L["Spellstone"] = "Piedra de hechizo"

-- Configuration panel text

L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Utilice el este panel para cambiar algunos ajustes básicos para los iconos de bufos, de debuffs, y de bufos de armas."
L["Buff Size"] = "Tamaño de bufos"
L["Set the size of each buff icon."] = "Fije el tamaño de cada icono de bufo."
L["Buff Spacing"] = "Espaciamiento de bufos"
L["Set the space between buff icons."] = "Fije el espaciamiento entre los iconos de bufos."
L["Buff Columns"] = "Columnas de bufos"
L["Set the number of buff icons to show on each row."] = "Fije el número de iconos de bufos para mostrar en cada fila."
L["Debuff Size"] = "Tamaño de debuffs"
L["Set the size of each debuff icon."] = "Fije el tamaño de cada icono de debuff."
L["Debuff Spacing"] = "Espaciamiento de debuffs"
L["Set the space between debuff icons."] = "Fije el espaciamiento entre los iconos de debuffs."
L["Debuff Columns"] = "Columnas de debuffs"
L["Set the number of debuff icons to show on each row."] = "Fije el número de iconos de debuffs para mostrar en cada fila."
L["Typeface"] = "Tipografía"
L["Set the typeface for stack count and timer text."] = "Fije la tipografía para los textos del contador del apilado y de tiempo."
L["Text Outline"] = "Esquema de texto"
L["Set the outline weight for stack count and timer text."] = "Fije el grueso del esquema para los textos del contador del apilado y de tiempo."
L["None"] = "Ninguno"
L["Thin"] = "Fino"
L["Thick"] = "Grueso"
L["Growth Anchor"] = "Ancla de iconos"
L["Set the side of the screen from which buffs and debuffs grow."] = "Fije el lado de la pantalla de la cual crecen bufos y debuffs."
L["Left"] = "Izquierda"
L["Right"] = ""Derecha
L["Buff Sources"] = "Taumaturgos de bufos"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Mostrar el nombre del miembro del grupo o de la banda que echa un bufo en usted en su tooltip."
L["Weapon Buff Sources"] = "Fuentes de bufos del arma"
L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "Mostrar los bufos del arma como el encanto o el artículo que encantaron el arma, en vez del arma sí mismo."
L["Lock Frames"] = "Bloquear celdas"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Bloquear celdas de bufos y debuffs, para ocultar el fondo y permitar el movimiento."

L["Now ignoring buff:"] = "El bufo será demostrado no más:"
L["No longer ignoring buff:"] = "El bufo ahora será demostrado:"
L["Now ignoring debuff:"] = "El debuff será demostrado no más:"
L["No longer ignoring debuff:"] = "El debuff ahora será demostrado:"
