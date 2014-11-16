--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs

	Please DO NOT upload this addon to other websites, or post modified
	versions of it. However, you are welcome to include a copy of it
	WITHOUT CHANGES in compilations posted on Curse and/or WoWInterface.
	You are also welcome to use any/all of its code in your own addon, as
	long as you do not use my name or the name of this addon ANYWHERE in
	your addon, including its name, outside of an optional attribution.
----------------------------------------------------------------------]]

local L, LOCALE, _, ns = {}, GetLocale(), ...
ns.L = L

if LOCALE == "enUS" then

-- Fake buff tooltip text
L[103985] = "Damage dealt increased by 10%.\nMovement speed increased by 10%." -- Stance of the Fierce Tiger
L[115069] = "Armor increased by 50%.\nStamina increased by 25%.\nMagic damage taken reduced by 10%." -- Stance of the Sturdy Ox
L[115070] = "Healing done increased by 20%." -- Stance of the Wise Serpent
L[154436] = "50% of all damage you deal with your melee attacks and abilities, including multistrikes, will be converted into healing on an injured ally within 20 yards." -- Stance of the Spirited Crane
L[105361] = "Melee attacks cause Holy damage." -- Seal of Command
L[20165] = "Casting speed improved by 10%.\nHealing done increased by 5%.\nMelee attacks have a chance to heal." -- Seal of Insight
L[20154] = "Melee attacks cause Holy damage against all targets within 8 yards." -- Seal of Righteousness
L[31801] = "Melee attacks cause Holy damage over 15 sec." -- Seal of Truth

return end

------------------------------------------------------------------------
--	German
-- Contributors: Phanx
------------------------------------------------------------------------

if LOCALE == "deDE" then

-- Fake buff tooltip text
L[103985] = "Sämtlichen verursachten Schaden um 10% erhöht.\nBewegungsgeschwindigkeit um 10% erhöht." -- Der wilde Tiger
L[115069] = "Rüstung um 50% erhöht.\nAusdauer um 25% erhöht.\nErlittenen magischen Schaden um 10% verringert." -- Der starke Ochse
L[115070] = "Hervorgerufene Heilung um 20% erhöht." -- Die weise Schlange
L[154436] = "50% des Schadens, den Ihr mit Euren Nahkampfangriffen und Fähigkeiten verursacht, einschließlich Mehrfachschlägen, heilt ein verletztes Ziel innerhalb von 20 Metern." -- Der edle Kranich
L[105361] = "Nahkampfangriffe verursachen Heiligschaden." -- Siegel des Befehls
L[20165] = "Zaubertempo um 10% erhöht.\nHervorgerufene Heilung um 5% erhöht.\nNahkampfangriffe haben eine Chance, Heilung hervorzurufen." -- Siegel der Einsicht
L[20154] = "Nahkampfangriffe fügen allen Zielen im Umkreis von 8 Metern Heiligschaden zu." -- Siegel der Rechtschaffenheit
L[31801] = "Nahkampfangriffe verursachen im Verlauf von 15 Sek. Heiligschaden." -- Siegel der Wahrheit

-- Broker tooltip
L["Click to lock or unlock the frames."] = "Klick, die Symbole zu fixieren oder freigeben."
L["Right-click for options."] = "Rechtsklick für Optionen."

-- Configuration panel
L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Mit diesen Optionen könnt Ihr die Stärkungszauber-, Schwächungszauber- und Waffenverzauberungssymbole dieses Addon konfigurieren."
L["Buff Size"] = "Stärkungszaubergröße"
L["Adjust the size of each buff icon."] = "Die Größe jedes Stärkungszaubersymbol ändern."
L["Buff Spacing"] = "Stärkungszauberabstand"
L["Adjust the space between buff icons."] = "Der Abstand zwischen den Stärkungszaubersymbolen ändern."
L["Buff Columns"] = "Stärkungszauberspalten"
L["Adjust the number of buff icons to show on each row."] = "Die Anzahl der Stärkungszaubersymbole ändern, die auf jeder Zeile anzeigen."
L["Buff Anchor"] = "Ankerpunkt der Stärkungszaubers"
L["Choose whether the buff icons grow from left to right, or right to left."] = "Wählen, ob die Stärkungszaubersymbole von links nach rechts oder von rechts nach links wachsen."
L["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "Wählen, ob die Stärkungszaubersymbole von oben nach unten order von unten nach oben wachsen."
L["Debuff Size"] = "Schwächungszaubergröße"
L["Adjust the size of each debuff icon."] = "Die Größe jedes Schwächungszaubersymbol ändern."
L["Debuff Spacing"] = "Schwächungszauberabstand"
L["Adjust the space between debuff icons."] = "Der Abstand zwischen den Schwächungszaubersymbolen ändern."
L["Debuff Columns"] = "Schwächungszauberspalten"
L["Adjust the number of debuff icons to show on each row."] = "Die Anzahl der Schwächungszaubersymbole ändern, die auf jeder Zeile anzeigen."
L["Debuff Anchor"] = "Ankerpunkt der Schwächungszaubers"
L["Choose whether the debuff icons grow from left to right, or right to left."] = "Wählen, ob die Schwächungszaubersymbole von links nach rechts oder von rechts nach links wachsen."
L["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "Wählen, ob die Schwächungszaubersymbole von oben nach unten order von unten nach oben wachsen."
L["Top"] = "Oben"
L["Bottom"] = "Unten"
L["Left"] = "Links"
L["Right"] = "Rechts"
L["Typeface"] = "Schriftart"
L["Set the typeface for the stack count and timer text."] = "Die Schriftart des Zahlen- und Timertext wählen."
L["Text Outline"] = "Schriftumriss"
L["Set the outline weight for the stack count and timer text."] = "Den Schriftumriss des Zahlen- und Timertext wählen."
L["None"] = "Keiner"
L["Thin"] = "Dünn"
L["Thick"] = "Dick"
L["Text Size"] = "Schriftgröße"
L["Adjust the size of the stack count and timer text."] = "Die Größe des Zahlen- und Timertext anpassen."
L["Max Timer Duration"] = "Höchstdauer"
L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "Die maximale Dauer in Sekunden anpassen, um den Timertext einer Stärkungs- oder Schwächungszauber anzeigen."
L["Show Stance Icons"] = "Haltungssymbole"
L["Show fake buff icons for monk stances and paladin seals."] = "Gefälschten Stärkungszaubersymbole für den Mönchshaltungen und Paladinsiegel anzeigen."
L["Show Buff Sources"] = "Stärkungszauberquellen"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Den Name des Gruppen- oder Schlachtzugsmitglied in Stärkungszaubertooltips anzeigen, das es auf euch gewirkt."
L["Cast by %s"] = "Von %s aufgebracht"
L["Lock Frames"] = "Symbole fixieren"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Die Stärkungs- und Schwächungszauber-Symbole fixieren, um den Hintergrund zu verstecken und die Bewegung zu verhindern." -- @PHANX: extra hyphen in Schwächungszaubersymbole because Blizz sucks at tooltip wrapping

-- Slash commands
L["lock"] = "fixieren"
L["unlock"] = "freigeben"
L["buff"] = "stärkungszauber"
L["debuff"] = "schwächungszauber"
L["Now ignoring buff: %s"] = "Der Stärkungszauber '%s' wird jetzt ignoriert."
L["Now ignoring debuff: %s"] = "Der Schwächungszauber '%s' wird jetzt ignoriert."
L["No longer ignoring buff: %s"] = "Der Stärkungszauber '%s' wird nicht mehr ignoriert."
L["No longer ignoring debuff: %s"] = "Der Schwächungszauber '%s' wird nicht mehr ignoriert."
L["No buffs are being ignored."] = "Keine Stärkungszauber werden ignoriert."
L["No debuffs are being ignored."] = "Keine Schwächungszauber werden ignoriert."
L["%d |4buff:buffs; |4is:are; being ignored:"] = "%d Stärkungszauber werden ignoriert."
L["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d Schwächungszauber werden ignoriert."

return end

------------------------------------------------------------------------
--	Spanish
-- Contributors: Akkorian, Phanx
------------------------------------------------------------------------

if LOCALE == "esES" or LOCALE == "esMX" then

-- Fake buff tooltip text
L[103985] = "Daño infligido aumentada un 10%.\nVelocidad de movimiento aumentada un 10%." -- Estilo del tigre fiero
L[115069] = "Armadura aumentada un 50%.\nAguante aumentada un 25%.\nDaño mágico recibido reducido un 10%." -- Estilo del buey robusto
L[115070] = "Sanación realizada mejorada um 20%." -- Estilo del dragón sabio
L[154436] = "Un 50% de todo el daño que inflijas con tus facultades y tus ataques cuerpo a cuerpo, multigolpes incluidos, se convertirá en sanación sobre un aliado herido en un radio de 20 m." -- Estilo de la grulla resuelta
L[105361] = "Ataques cuerpo a cuerpo infligen daño Sagrado." -- Sello de orden
L[20165] = "Velocidad de lanzamiento mejorada un 10%.\nSanación realizada mejorada un 5%.\nLos ataques cuerpo a cuerpo tienen una probabilidad de sanar." -- Sello de Perspicacia
L[20154] = "Ataques cuerpo a cuerpo infligen daño Sagrado a todos los objetivos en un radio de 8 m." -- Sello de Rectitud
L[31801] = "Ataques cuerpo a cuerpo infligen daño Sagrado durante 15 s." -- Sello de Verdad

-- Broker tooltip
L["Click to lock or unlock the frames."] = "Clic para bloquear o desbloquear los iconos."
L["Right-click for options."] = "Clic derecho para opciones."

-- Configuration panel text
L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Estes opciones te permiten configurar los iconos de beneficios, perjuicios, y encancamientos de armas."
L["Buff Size"] = "Tamaño de beneficios"
L["Adjust the size of each buff icon."] = "Ajustar el tamaño de los iconos de beneficios."
L["Buff Spacing"] = "Espaciamiento de beneficios"
L["Adjust the space between buff icons."] = "Ajustar el espaciamiento entre los iconos de beneficios."
L["Buff Columns"] = "Columnas de beneficios"
L["Adjust the number of buff icons to show on each row."] = "Ajustar el número de iconos de beneficios para mostrar en cada fila."
L["Buff Anchor"] = "Ancla de beneficios"
L["Choose whether the buff icons grow from left to right, or right to left."] = "Seleccionar entre extender los iconos de beneficios de la derecha a la izquierda, o de la izquierda a la derecha."
L["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "Seleccionar entre extender los iconos de beneficios de arriba a abajo, o de abajo a arriba."
L["Debuff Size"] = "Tamaño de perjuicios"
L["Adjust the size of each debuff icon."] = "Ajustar el tamaño de los icons de perjuicios."
L["Debuff Spacing"] = "Espaciamiento de perjuicios"
L["Adjust the space between debuff icons."] = "Ajustar el espaciamiento entre los iconos de perjuicios."
L["Debuff Columns"] = "Columnas de perjuicios"
L["Adjust the number of debuff icons to show on each row."] = "Ajustar el número de iconos de perjuicios para mostrar en cada fila."
L["Debuff Anchor"] = "Ancla de perjuicios"
L["Choose whether the debuff icons grow from left to right, or right to left."] = "Seleccionar entre extender los iconos de perjuicios de la derecha a la izquierda, o de la izquierda a la derecha."
L["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "Seleccionar entre extender los iconos de perjuicios de la arriba a abajo, o de abajo a arriba."
L["Top"] = "Arriba"
L["Bottom"] = "Abajo"
L["Left"] = "Izquierda"
L["Right"] = "Derecha"
L["Typeface"] = "Tipo de letra"
L["Set the typeface for the stack count and timer text."] = "Establecer el tipo de letra del texto de aplicaciones y tiempo."
L["Text Outline"] = "Perfil de texto"
L["Set the outline weight for the stack count and timer text."] = "Establecer el grueso del perfil del texto de aplicaciones y tiempo."
L["None"] = "Ninguno"
L["Thin"] = "Fino"
L["Thick"] = "Grueso"
L["Text Size"] = "Tamaño de texto"
L["Adjust the size of the stack count and timer text."] = "Ajustar el tamaño del texto de aplicaciones y tiempo."
L["Max Timer Duration"] = "Tiempo máximo"
L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "Ajustar el máximo de tiempo restante, en segundos, para mostrar el texto de tiempo."
L["Show Stance Icons"] = "Iconos de actitudes"
L["Show fake buff icons for monk stances and paladin seals."] = "Mostrar iconos falsos para los actitudes de monjes y los sellos de paladins."
L["Show Buff Sources"] = "Taumaturgos de beneficios"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Mostrar el nombre del miembro del grupo o banda que ha aplicado un beneficio a te en su descripción."
L["Cast by %s"] = "Aplicada por %s"
L["Lock Frames"] = "Bloquear iconos"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Bloquear las iconos de beneficios y perjuicios, para ocultar el fondo y prevenir el movimiento."

-- Slash commands
L["lock"] = "bloquear"
L["unlock"] = "desbloquear"
L["buff"] = "beneficio"
L["debuff"] = "perjuicio"
L["Now ignoring buff: %s"] = "Estás ignorando al beneficio: %s"
L["Now ignoring debuff: %s"] = "Estás ignorando al perjuicio: %s"
L["No longer ignoring buff: %s"] = "Ya no estás ignorando al beneficio: %s"
L["No longer ignoring debuff: %s"] = "Ya no estás ignorando al perjucio: %s"
L["No buffs are being ignored."] = "No estás ignorando a ningún beneficios."
L["No debuffs are being ignored."] = "No estás ignorando a ningún perjuicios."
L["%d |4buff:buffs; |4is:are; being ignored:"] = "Estás ignorando a %d |4beneficio:beneficios;:"
L["%d |4debuff:debuffs; |4is:are; being ignored:"] = "Estás ignorando a %d |perjuicio:perjuicios;:"

return end

------------------------------------------------------------------------
--	French
-- Contributors: Strigx
------------------------------------------------------------------------

if LOCALE == "frFR" then

-- Fake buff tooltip text
L[103985] = "Dégâts infligés augmentée de 10%.\nVitesse de déplacement augmentée de 10%." -- Posture du tigre féroce
L[115069] = "Armure augmentée de 50%.\nEndurance augmentée de 25%.\nDégâts magiques subis réduite de 10%." -- Posture du buffle vigoureux
L[115070] = "Soins prodigués augmentés de 20%." -- Posture du serpent avisé
L[154436] = "50% de tous les dégâts que vous infligez avec vos techniques et attaques en mêlée, y compris les frappes multiples, sont convertis en soins pour un allié blessé à moins de 20 mètres." -- Posture de la grue fougueuse
L[105361] = "Attaques de mêlée infligent des dégâts du Sacré." -- Sceau d’autorité
L[20165] = "Vitesse d’incantation augmentée de 10%.\nSoins prodigués augmentés de 5%.\nLes attaques de mêlée ont une chance de soigner." -- Sceau de clairvoyance
L[20154] = "Attaques de mêlée infligent des dégâts du Sacré à toutes les cibles à moins de 8 mètres." -- Sceau de piété
L[31801] = "Attaques de mêlée infligent des dégâts du Sacré en 15 s." -- Sceau de vérité

-- Broker tooltip
--L["Click to lock or unlock the frames."] = ""
--L["Right-click for options."] = ""

-- Configuration panel
L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Utilisez cette fenêtre pour ajuster des réglages basiques pour les icônes de buffs, debuffs, et buffs d'arme."
L["Buff Size"] = "Taille des Buffs"
L["Adjust the size of each buff icon."] = "Configure la taille de chaque icône de buff."
L["Buff Spacing"] = "Espacement des Buffs"
L["Adjust the space between buff icons."] = "Configure l'espacement entre les icônes des buffs."
L["Buff Columns"] = "Colonnes de Buffs"
L["Adjust the number of buff icons to show on each row."] = "Configure le nombre d'icônes de Buffs à afficher par ligne."
L["Buff Anchor"] = "Ancrage des Buffs"
--L["Choose whether the buff icons grow from left to right, or right to left."] = ""
--L["Choose whether the buff icons grow from top to bottom, or bottom to top."] = ""
L["Debuff Size"] = "Taille des Debuffs"
L["Adjust the size of each debuff icon."] = "Configure la taille de chaque icône de debuff."
L["Debuff Spacing"] = "Espacement des Debuffs"
L["Adjust the space between debuff icons."] = "Configure l'espacement entre les icônes des debuffs."
L["Debuff Columns"] = "Colonnes de Debuffs"
L["Adjust the number of debuff icons to show on each row."] = "Configure le nombre d'icônes de Debuffs à afficher par ligne."
L["Debuff Anchor"] = "Ancrage des Debuffs"
--L["Choose whether the debuff icons grow from left to right, or right to left."] = ""
--L["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = ""
--L["Top"] = ""
--L["Bottom"] = ""
L["Left"] = "Gauche"
L["Right"] = "Droite"
L["Typeface"] = "Police"
L["Set the typeface for the stack count and timer text."] = "Configure la police de texte des compteurs de stack et du timer."
L["Text Outline"] = "Contour du Texte"
L["Set the outline weight for the stack count and timer text."] = "Configure l'épaisseur du contour des textes de stack et timer."
L["None"] = "Aucun"
L["Thin"] = "Fin"
L["Thick"] = "Epais"
--L["Text Size"] = ""
--L["Adjust the size of the stack count and timer text."] = ""
--L["Max Timer Duration"] = ""
--L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = ""
--L["Show Stance Icons"] = ""
--L["Show fake buff icons for monk stances and paladin seals."] = ""
L["Show Buff Sources"] = "Origines des Buffs"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Affiche dans le tooltip du buff le nom du membre du groupe ou raid qui l'a incanté."
L["Cast by %s"] = "Incanté par %s"
L["Lock Frames"] = "Verrouiller les cadres"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Verrouille les cadres de Buffs et Debuffs, masquant le fond et empechant de les déplacer."

-- Slash commands
L["lock"] = "verrouiller"
L["unlock"] = "déverrouiller"
L["buff"] = "buff"
L["debuff"] = "debuff"
L["Now ignoring buff: %s"] = "Buff à présent ignoré : %s"
L["Now ignoring debuff: %s"] = "Debuff à présent ignoré : %s"
L["No longer ignoring buff: %s"] = "Buff n'étant à présent plus ignoré : %s"
L["No longer ignoring debuff: %s"] = "Debuff n'étant à présent plus ignoré : %s"
L["No buffs are being ignored."] = "Aucun buffs sont ignorés."
L["No debuffs are being ignored."] = "%d buffs actuellement ignorés :"
L["%d |4buff:buffs; |4is:are; being ignored:"] = "Aucun debuffs sont ignorés."
L["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d debuffs actuellement ignorés :"

return end

------------------------------------------------------------------------
--	Italian
-- Contributors: Phanx
------------------------------------------------------------------------

if LOCALE == "itIT" then

-- Fake buff tooltip text
L[103985] = "Danni inflitti aumentata del 10%.\nVelocità di movimento aumentata del 10%." -- Stile della Tigre
L[115069] = "Armatura aumentata del 50%.\nTempra aumentata del 25%.\nDanni magici subiti ridotta del 10%." -- Stile dello Yak
L[115070] = "Cure fornite aumentate del 20%." -- Stile della Serpe
L[154436] = "Il 50% di tutti i danni inflitti in mischia e con le abilità, inclusi i danni replicati, vengono convertiti in cure per un bersaglio alleato ferito entro 20 m." -- Stile della Gru
L[105361] = "Danni da sacro inflitti dagli attacchi in mischia." -- Sigillo di Comando
L[20165] = "Velocità di lancio d'incantesimi aumentata del 10%.\nCure fornite aumentate del 5%.\nGli attacchi in mischia hanno una probabilità di curare." -- Sigillo della Consapevolezza
L[20154] = "Gli attacchi in mischia infliggono danni da sacro contro tutti i bersagli entro 8 m." -- Sigillo della Rettitudine
L[31801] = "Danni da sacro inflitti dagli attacchi in mischia in 15 s." -- Sigillo della Verità

-- Broker tooltip
--L["Click to lock or unlock the frames."] = ""
--L["Right-click for options."] = ""

-- Configuration panel
--L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."
L["Buff Size"] = "Dimensione di benefici"
--L["Adjust the size of each buff icon."] = "Adjust the size of each buff icon."
L["Buff Spacing"] = "Spaziatura di benefici"
--L["Adjust the space between buff icons."] = "Adjust the space between buff icons."
L["Buff Columns"] = "Colonne di benefici"
--L["Adjust the number of buff icons to show on each row."] = "Adjust the number of buff icons to show on each row."
L["Buff Anchor"] = "Ancoraggio di benefici"
--L["Choose whether the buff icons grow from left to right, or right to left."] = "Choose whether the buff icons grow from left to right, or right to left."
--L["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "Choose whether the buff icons grow from top to bottom, or bottom to top."
L["Debuff Size"] = "Dimensioni di malefici"
--L["Adjust the size of each debuff icon."] = "Adjust the size of each debuff icon."
L["Debuff Spacing"] = "Spaziatura di malefici"
--L["Adjust the space between debuff icons."] = "Adjust the space between debuff icons."
L["Debuff Columns"] = "Colonne di malefici"
--L["Adjust the number of debuff icons to show on each row."] = "Adjust the number of debuff icons to show on each row."
L["Debuff Anchor"] = "Ancoraggio di malefici"
--L["Choose whether the debuff icons grow from left to right, or right to left."] = "Choose whether the debuff icons grow from left to right, or right to left."
--L["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "Choose whether the debuff icons grow from top to bottom, or bottom to top."
L["Top"] = "Alto"
L["Bottom"] = "Basso"
L["Left"] = "Sinistra"
L["Right"] = "Destra"
L["Typeface"] = "Tipo di carattere"
--L["Set the typeface for the stack count and timer text."] = "Set the typeface for the stack count and timer text."
L["Text Outline"] = "Contorno di carattere"
--L["Set the outline weight for the stack count and timer text."] = "Set the outline weight for the stack count and timer text."
L["None"] = "Nessuno"
L["Thin"] = "Sottile"
L["Thick"] = "Spesso"
L["Text Size"] = "Dimensione di carattere"
--L["Adjust the size of the stack count and timer text."] = "Adjust the size of the stack count and timer text."
L["Max Timer Duration"] = "Durata massima per testo"
--L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."
--L["Show Stance Icons"] = ""
--L["Show fake buff icons for monk stances and paladin seals."] = ""
L["Show Buff Sources"] = "Origini di benefici"
--L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Show the name of the party or raid member who cast a buff on you in its tooltip."
L["Cast by %s"] = "Lanciato da %s"
L["Lock Frames"] = "Blocca icone"
--L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."

-- Slash commands
L["lock"] = "blocca"
L["unlock"] = "sblocca"
L["buff"] = "beneficio"
L["debuff"] = "maleficio"
L["Now ignoring buff: %s"] = "Ora ignorando il beneficio: %s"
L["Now ignoring debuff: %s"] = "Ora ignorando il maleficio: %s"
L["No longer ignoring buff: %s"] = "Non più ignorando il beneficio: %s"
L["No longer ignoring debuff: %s"] = "Non più ignorando il maleficio: %s"
L["No buffs are being ignored."] = "Nessun benefici vengono ignorati."
L["No debuffs are being ignored."] = "Nessun malefici vengono ignorati."
L["%d |4buff:buffs; |4is:are; being ignored:"] = "%d |4beneficio viene ignorato:benefici vengono ignorati;:"
L["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d |4maleficio viene ignorato:malefici vengono ignorati;:"

return end

------------------------------------------------------------------------
--	Portuguese
-- Contributors: Phanx, Tercioo
------------------------------------------------------------------------

if LOCALE == "ptBR" then

-- Fake buff tooltip text
L[103985] = "Dano causado aumentada em 10%.\nVelocidade de movimento aumentada em 10%." -- Postura do Tigre Agressivo
L[115069] = "Armadura aumentada em 50%.\nVigor aumentada em 25%.\nDano mágico recebido reduzido em 10%." -- Postura do Boi Resistente
L[115070] = "Cura realizada aumentada em 20%." -- Postura da Serpente Sábia
L[154436] = "50% de todo o dano causado por ataques e habilidades corpo a corpo, inclusive de Golpes Múltiplos, é convertido em cura para um aliado ferido em um raio de 20 m." -- Postura da Garça Impetuosa
L[105361] = "Ataques corpo a corpo causam dano Sagrado." -- Selo da Retidão
L[20165] = "Velocidade de lançamento aumentada em 10%.\nCura realizada aumentada em 5%.\nAtaques corpo a corpo têm chance curar." -- Selo da Intuição
L[20154] = "Ataques corpo a corpo causam dano Sagrado contra todos os alvos em um raio de 8 metros." -- Selo da Retidão
L[31801] = "Ataques corpo a corpo causam dano Sagrado ao longo de 15 s." -- Selo da Verdade

-- Broker tooltip
--L["Click to lock or unlock the frames."] = ""
--L["Right-click for options."] = ""

-- Configuration panel
L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Estas opções permitem alterar algumas configurações básicas para os ícones de bônus, penalidades, e encantamentos de armas."
L["Buff Size"] = "Tamanho dos bônus"
L["Adjust the size of each buff icon."] = "Alterar o tamanho de cada ícone de bônus."
L["Buff Spacing"] = "Espaçamento dos bônus"
L["Adjust the space between buff icons."] = "Alterar o espaço entre ícones de bônus."
L["Buff Columns"] = "Colunas dos bônus"
L["Adjust the number of buff icons to show on each row."] = "Alterar o número de ícones de bônus para mostrar em cada linha."
L["Buff Anchor"] = "Ponto inicial dos bônus"
L["Choose whether the buff icons grow from left to right, or right to left."] = "Escolher se estender os ícones de bônus de direita a esquerda, ou de esquerda a direita."
L["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "Escolher se estender os ícones de bônus de topo a fundo, ou de fundo a topo."
L["Debuff Size"] = "Tamanho das penalidades"
L["Adjust the size of each debuff icon."] = "Alterar o tamanho de cada ícone de penalidade."
L["Debuff Spacing"] = "Espaçamento das penalidades"
L["Adjust the space between debuff icons."] = "Alterar o espaço entre ícones de penalidades."
L["Debuff Columns"] = "Colunas dos bônus"
L["Adjust the number of debuff icons to show on each row."] = "Alterar o número de ícones de penalidades para mostrar em cada linha."
L["Debuff Anchor"] = "Ponto inicial dos bônus"
L["Choose whether the debuff icons grow from left to right, or right to left."] = "Escolher se estender os ícones de penalidades de direita a esquerda, ou de esquerda a direita."
L["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "Escolher se estender os ícones de penalidades de topo a fundo, ou de fundo a topo."
L["Top"] = "Topo"
L["Bottom"] = "Fundo"
L["Left"] = "Esquerda"
L["Right"] = "Direita"
L["Typeface"] = "Tipo de letra"
L["Set the typeface for the stack count and timer text."] = "Escolher o tipo de letra para o texto da contagem de aplicação e tempo restante."
L["Text Outline"] = "Contorno do texto"
L["Set the outline weight for the stack count and timer text."] = "Escolher a espessura da linha de contorno para o texto da contagem de aplicação e tempo restante."
L["None"] = "Nenhum"
L["Thin"] = "Fino"
L["Thick"] = "Espesso"
L["Text Size"] = "Tamanho do texto"
L["Adjust the size of the stack count and timer text."] = "Ajustar o tamanho do texto da contagem de aplicação e tempo restante."
L["Max Timer Duration"] = "Duração máxima da cronometrista"
L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "Alterar o máximo de tempo restante, em segundos, para mostrar o texto de tempo para um bônus ou penalidade."
L["Show Stance Icons"] = "Mostrar ícones de posturas"
L["Show fake buff icons for monk stances and paladin seals."] = "Mostrar auras representando posturas de monges e selos de paladinos."
L["Show Buff Sources"] = "Origens dos bônus"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Mostrar na dica o nome do membro do grupo que aplicou em você o bônus."
L["Cast by %s"] = "Aplicada por %s"
L["Lock Frames"] = "Travar ícones"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Travar os ícones no lugar e esconder o fundo."

-- Slash commands
L["lock"] = "travar"
L["unlock"] = "destravar"
L["buff"] = "bônus"
L["debuff"] = "penalidade"
L["Now ignoring buff: %s"] = "Agora ignorando o bônus: %s"
L["Now ignoring debuff: %s"] = "Agora ignorando o penalidade: %s"
L["No longer ignoring buff: %s"] = "Já não ignorando o bônus: %s"
L["No longer ignoring debuff: %s"] = "Já não ignorando o penalidade: %s"
L["No buffs are being ignored."] = "Não há bônus são ignorados."
L["No debuffs are being ignored."] = "Não há penalidades são ignoradas."
L["%d |4buff:buffs; |4is:are; being ignored:"] = "%d bônus |4é:são; |4ignorada:ignoradas;:"
L["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d |4penalidade:penalidades; |4é:são; |4ignorada:ignoradas;:"

return end

------------------------------------------------------------------------
--	Russian
-- Contributors: Yafis
------------------------------------------------------------------------

if LOCALE == "ruRU" then

-- Fake buff tooltip text
L[103985] = "Наносимый урон увеличивается на 10%.\nСкорость передвижения повышается на 10%." -- Стойка разъяренного тигра
L[115069] = "Показатель брони увеличивается на 50%.\nВыносливость повышается на 25%.\nПолучаемый урон от магии уменьшается на 10%." -- Стойка упорного быка
L[115070] = "Эффективность лечения повышена на 20%." -- Стойка мудрой змеи
L[154436] = "50% от урона, нанесенного вашими атаками ближнего боя и способностями, включая многократные атаки, восполняется в виде здоровья раненому союзнику, находящемуся в радиусе 20 м." -- Стойка смелого журавля
L[105361] = "Атаки ближнего боя дополнительно наносят урон от светлой магии." -- Печать повиновения
L[20165] = "Скорость произнесения заклинаний повышена на 10%.\nЭффективность лечения повышена на 5%.\nАтаки ближнего боя могут исцелить вас." -- Печать прозрения
L[20154] = "Атаки ближнего боя наносят урон от светлой магии всем целям в радиусе 8 м." -- Печать праведности
L[31801] = "Атаки ближнего боя дополнительно наносят урон от светлой магии в течение 15 сек." -- Печать правды

-- Broker tooltip
--L["Click to lock or unlock the frames."] = ""
--L["Right-click for options."] = ""

-- Configuration panel
L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Эти настройки позволяют настроить значков для положительных и отрицательных эффектов, и чар, связанных с оружием."
L["Buff Size"] = "Размер баффы"
L["Adjust the size of each buff icon."] = "Настроить размера значков положительного эффекта."
L["Buff Spacing"] = "Расстояние баффы"
L["Adjust the space between buff icons."] = "Настроить расстояния между значков положительного эффекта."
L["Buff Columns"] = "Столбцов баффы"
L["Adjust the number of buff icons to show on each row."] = "Настроить числа положительный эффект значков для отображения на каждой строке."
L["Buff Anchor"] = "Бафф Якорь"
L["Choose whether the buff icons grow from left to right, or right to left."] = "Будут ли иконки баффа расти с лева на право или с права на лева."
L["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "Будут ли иконки баффа расти с верху в низ или с низу в верх."
L["Debuff Size"] = "Размер дебаффы"
L["Adjust the size of each debuff icon."] = "Настроить размера значков отрицательного эффекта."
L["Debuff Spacing"] = "Расстояние дебаффы"
L["Adjust the space between debuff icons."] = "Настроить расстояния между значков отрицательного эффекта."
L["Debuff Columns"] = "Столбцов дебаффы"
L["Adjust the number of debuff icons to show on each row."] = "Настроить числа отрицательных эффекта значков для отображения на каждой строке."
L["Debuff Anchor"] = "Дебафф Якорь"
L["Choose whether the debuff icons grow from left to right, or right to left."] = "Будут ли иконки дебаффа расти с лева на право или с права на лева."
L["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "Будут ли иконки дебаффа расти с верху в низ или с низу в верх."
L["Top"] = "Верх"
L["Bottom"] = "Низ"
L["Left"] = "Слева"
L["Right"] = "Справа"
L["Typeface"] = "Шрифт"
L["Set the typeface for the stack count and timer text."] = "Настроить шрифт для имя и заряд счетчиков."
L["Text Outline"] = "Контур шрифта"
L["Set the outline weight for the stack count and timer text."] = "Настроить контура шрифта."
L["None"] = "Нету"
L["Thin"] = "Тонкий"
L["Thick"] = "Толстый"
L["Text Size"] = "Размер шрифта"
L["Adjust the size of the stack count and timer text."] = "Настроить размера шрифта."
L["Max Timer Duration"] = "Максимальное время"
L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "Установите максимальное количество времени в секундах, чтобы показать отметчик времени для эффект."
--L["Show Stance Icons"] = ""
--L["Show fake buff icons for monk stances and paladin seals."] = ""
L["Show Buff Sources"] = "Источники баффы"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Показать имя персонажа который наложил положительный эффект на вас во всплывающих подсказках."
L["Cast by %s"] = "Наносится %s"
L["Lock Frames"] = "Заблокировать значки"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Заблокировать значки, предотвращение перемещения и скрытия фона."

-- Slash commands
L["lock"] = "заблокировать"
L["unlock"] = "разблокировать"
L["buff"] = "бафф"
L["debuff"] = "дебафф"
L["Now ignoring buff: %s"] = "Теперь игнорируя бафф: %s"
L["Now ignoring debuff: %s"] = "Теперь игнорируя дебафф: %s"
L["No longer ignoring buff: %s"] = "Больше не игнорируя бафф: %s"
L["No longer ignoring debuff: %s"] = "Больше не игнорируя дебафф: %s"
L["No buffs are being ignored."] = "Вы не игнорируя любые баффы."
L["No debuffs are being ignored."] = "Вы не игнорируя любые дебаффы"
L["%d |4buff:buffs; |4is:are; being ignored:"] = "Вы игнорируете %d |4бафф:баффы;."
L["%d |4debuff:debuffs; |4is:are; being ignored:"] = "Вы игнорируете %d |4дебафф:дебаффы;."

return end

------------------------------------------------------------------------
--	Korean
-- Contributors: Bruteforce
------------------------------------------------------------------------

if LOCALE == "koKR" then

-- Fake buff tooltip text
--L[103985] = "Damage dealt increased by 10%.\nMovement speed increased by 10%." -- Stance of the Fierce Tiger
--L[115069] = "Armor increased by 50%.\nStamina increased by 25%.\nMagic damage taken reduced by 10%." -- Stance of the Sturdy Ox
--L[115070] = "Healing done increased by 20%." -- Stance of the Wise Serpent
--L[154436] = "50% of all damage you deal with your melee attacks and abilities, including multistrikes, will be converted into healing on an injured ally within 20 yards." -- Stance of the Spirited Crane
--L[105361] = "Melee attacks cause Holy damage." -- Seal of Command
--L[20165] = "Casting speed improved by 10%.\nHealing done increased by 5%.\nMelee attacks have a chance to heal." -- Seal of Insight
--L[20154] = "Melee attacks cause Holy damage against all targets within 8 yards." -- Seal of Righteousness
--L[31801] = "Melee attacks cause Holy damage over 15 sec." -- Seal of Truth

-- Broker tooltip
--L["Click to lock or unlock the frames."] = ""
--L["Right-click for options."] = ""

-- Configuration panel
L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "이 패널을 이용해서 버프, 디버프 그리고 무기 버프 아이콘을 위해 약간의 간단한 설정을 조정하세요."
L["Buff Size"] = "버프 크기"
L["Adjust the size of each buff icon."] = "각각의 버프 아이콘 크기를 설정합니다."
L["Buff Spacing"] = "버프 간격"
L["Adjust the space between buff icons."] = "버프 아이콘 사이의 공간을 설정합니다."
L["Buff Columns"] = "버프 열"
L["Adjust the number of buff icons to show on each row."] = "각각의 행에 보여질 버프 아이콘의 갯수를 설정합니다."
L["Buff Anchor"] = "버프 성장 기준점"
--L["Choose whether the buff icons grow from left to right, or right to left."] = ""
--L["Choose whether the buff icons grow from top to bottom, or bottom to top."] = ""
L["Debuff Size"] = "디버프 크기"
L["Adjust the size of each debuff icon."] = "디버프 아이콘 크기를 설정합니다."
L["Debuff Spacing"] = "디버프 간격"
L["Adjust the space between debuff icons."] = "디버프 아이콘 사이의 공간을 설정합니다."
L["Debuff Columns"] = "디버프 열"
L["Adjust the number of debuff icons to show on each row."] = "각각의 행에 보여질 디버프 아이콘의 갯수를 설정합니다."
L["Debuff Anchor"] = "디버프 성장 기준점"
--L["Choose whether the debuff icons grow from left to right, or right to left."] = ""
--L["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = ""
L["Top"] = "상단"
L["Bottom"] = "하단"
L["Left"] = "왼쪽"
L["Right"] = "오른쪽"
L["Typeface"] = "글꼴"
L["Set the typeface for the stack count and timer text."] = "중첩 카운트와 타이머 텍스트를 위해 글꼴을 설정합니다."
L["Text Outline"] = "글꼴 외각선"
L["Set the outline weight for the stack count and timer text."] = "중첩 카운트와 타이머 텍스트를 위해 외곽선 두께를 설정합니다."
L["None"] = "없음"
L["Thin"] = "얇게"
L["Thick"] = "두껍게"
L["Text Size"] = "글꼴 크기"
L["Adjust the size of the stack count and timer text."] = "중첩 카운트와 타이머 텍스트를 위해 글꼴 크기를 설정합니다."
L["Max Timer Duration"] = "최대 시간"
L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "최대 시간, 초, 타이머를 표시합니다."
--L["Show Stance Icons"] = ""
--L["Show fake buff icons for monk stances and paladin seals."] = ""
L["Show Buff Sources"] = "버프 출처"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "파티원 또는 공격대원 중 당신에게 버프를 시전한 누군가의 이름을 툴팁에 보여줍니다."
L["Cast by %s"] = "시전자: %s"
L["Lock Frames"] = "프레임 잠금"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "해당 위치에 버프와 디버프 프레임을 잠급니다. 배경을 숨기고 움직이지 못하도록 합니다."

-- Slash commands
L["lock"] = "잠금"
L["unlock"] = "해제"
L["buff"] = "버프"
L["debuff"] = "디버프"
L["Now ignoring buff: %s"] = "버프 %s 님이 차단 목록에 등록되었습니다."
L["Now ignoring debuff: %s"] = "디버프 %s 님이 차단 목록에 등록되었습니다."
L["No longer ignoring buff: %s"] = "버프%s 님이 차단 목록에서 제외되었습니다."
L["No longer ignoring debuff: %s"] = "디버프 %s 님이 차단 목록에서 제외되었습니다."
L["No buffs are being ignored."] = "아니 디버프가 차단 목록에 있습니다."
L["No debuffs are being ignored."] = "아니 버프가 차단 목록에 있습니다."
L["%d |4buff:buffs; |4is:are; being ignored:"] = "%d 버프가 차단 목록에 있습니다:"
L["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d 디버프가 차단 목록에 있습니다:"

return end

------------------------------------------------------------------------
--	Simplified Chinese
-- Contributors: wowuicn
------------------------------------------------------------------------

if LOCALE == "zhCN" then

-- Fake buff tooltip text
--L[103985] = "Damage dealt increased by 10%.\nMovement speed increased by 10%." -- Stance of the Fierce Tiger
--L[115069] = "Armor increased by 50%.\nStamina increased by 25%.\nMagic damage taken reduced by 10%." -- Stance of the Sturdy Ox
--L[115070] = "Healing done increased by 20%." -- Stance of the Wise Serpent
--L[154436] = "50% of all damage you deal with your melee attacks and abilities, including multistrikes, will be converted into healing on an injured ally within 20 yards." -- Stance of the Spirited Crane
--L[105361] = "Melee attacks cause Holy damage." -- Seal of Command
--L[20165] = "Casting speed improved by 10%.\nHealing done increased by 5%.\nMelee attacks have a chance to heal." -- Seal of Insight
--L[20154] = "Melee attacks cause Holy damage against all targets within 8 yards." -- Seal of Righteousness
--L[31801] = "Melee attacks cause Holy damage over 15 sec." -- Seal of Truth

-- Broker tooltip
--L["Click to lock or unlock the frames."] = ""
--L["Right-click for options."] = ""

-- Configuration panel
--L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = ""
L["Buff Size"] = "Buff 大小"
--L["Adjust the size of each buff icon."] = ""
--L["Buff Spacing"] = ""
--L["Adjust the space between buff icons."] = ""
L["Buff Columns"] = "Buff 栏"
--L["Adjust the number of buff icons to show on each row."] = ""
L["Buff Anchor"] = "Buff 增长锚点"
--L["Choose whether the buff icons grow from left to right, or right to left."] = ""
--L["Choose whether the buff icons grow from top to bottom, or bottom to top."] = ""
L["Debuff Size"] = "Debuff 大小"
--L["Adjust the size of each debuff icon."] = ""
--L["Debuff Spacing"] = ""
--L["Adjust the space between debuff icons."] = ""
L["Debuff Columns"] = "Debuff 栏"
--L["Adjust the number of debuff icons to show on each row."] = ""
L["Debuff Anchor"] = "Debuff 增长锚点"
--L["Choose whether the debuff icons grow from left to right, or right to left."] = ""
--L["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = ""
--L["Top"] = ""
--L["Bottom"] = ""
L["Left"] = "左侧"
--L["Right"] = ""
--L["Typeface"] = ""
--L["Set the typeface for the stack count and timer text."] = ""
--L["Text Outline"] = ""
--L["Set the outline weight for the stack count and timer text."] = ""
--L["None"] = ""
--L["Thin"] = ""
--L["Thick"] = ""
--L["Text Size"] = ""
--L["Adjust the size of the stack count and timer text."] = ""
--L["Max Timer Duration"] = ""
--L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = ""
--L["Show Stance Icons"] = ""
--L["Show fake buff icons for monk stances and paladin seals."] = ""
L["Show Buff Sources"] = "Buff 来源"
--L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = ""
L["Cast by %s"] = "来自 %s"
--L["Weapon Buff Sources"] = ""
--L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = ""
L["Lock Frames"] = "锁定框体"
--L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = ""

-- Slash commands
L["lock"] = "锁定"
L["unlock"] = "解锁"
--L["buff"] = ""
--L["debuff"] = ""
--L["Now ignoring buff: %s"] = ""
--L["Now ignoring debuff: %s"] = ""
--L["No longer ignoring buff: %s"] = ""
--L["No longer ignoring debuff: %s"] = ""
--L["No buffs are being ignored."] = ""
--L["No debuffs are being ignored."] = ""
--L["%d |4buff:buffs; |4is:are; being ignored:"] = ""
--L["%d |4debuff:debuffs; |4is:are; being ignored:"] = ""

return end

------------------------------------------------------------------------
--	Traditional Chinese
-- Contributors: BNSSNB, fmdsm
------------------------------------------------------------------------

if LOCALE == "zhTW" then

-- Fake buff tooltip text
--L[103985] = "Damage dealt increased by 10%.\nMovement speed increased by 10%." -- Stance of the Fierce Tiger
--L[115069] = "Armor increased by 50%.\nStamina increased by 25%.\nMagic damage taken reduced by 10%." -- Stance of the Sturdy Ox
--L[115070] = "Healing done increased by 20%." -- Stance of the Wise Serpent
--L[154436] = "50% of all damage you deal with your melee attacks and abilities, including multistrikes, will be converted into healing on an injured ally within 20 yards." -- Stance of the Spirited Crane
--L[105361] = "Melee attacks cause Holy damage." -- Seal of Command
--L[20165] = "Casting speed improved by 10%.\nHealing done increased by 5%.\nMelee attacks have a chance to heal." -- Seal of Insight
--L[20154] = "Melee attacks cause Holy damage against all targets within 8 yards." -- Seal of Righteousness
--L[31801] = "Melee attacks cause Holy damage over 15 sec." -- Seal of Truth

-- Broker tooltip
--L["Click to lock or unlock the frames."] = ""
--L["Right-click for options."] = ""

-- Configuration panel
L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "這裡可以調整buff,debuff,武器附魔圖示的基本設置."
L["Buff Size"] = "buff大小"
L["Adjust the size of each buff icon."] = "設置buff圖示大小"
L["Buff Spacing"] = "buff間距"
L["Adjust the space between buff icons."] = "設置buff圖示間距"
L["Buff Columns"] = "buff列數"
L["Adjust the number of buff icons to show on each row."] = "設置buff圖示每行顯示的個數"
L["Buff Anchor"] = "buff描點對齊"
L["Choose whether the buff icons grow from left to right, or right to left."] = "選擇增益圖標是從左到右伸展，還是從右到左。"
L["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "選擇增益圖標是從上往下延展，還是從下到上。"
L["Debuff Size"] = "debuff大小"
L["Adjust the size of each debuff icon."] = "設置debuff圖示大小"
L["Debuff Spacing"] = "debuff間距"
L["Adjust the space between debuff icons."] = "設置debuff圖示間距"
L["Debuff Columns"] = "debuff列數"
L["Adjust the number of debuff icons to show on each row."] = "設置debuff圖示每行顯示的個數"
L["Debuff Anchor"] = "debuff描點對齊"
L["Choose whether the debuff icons grow from left to right, or right to left."] = "選擇減益圖標是從左到右伸展，還是從右到左。"
L["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "選擇減益圖標是從上往下延展，還是從下到上。"
L["Top"] = "頂部"
L["Bottom"] = "底部"
L["Left"] = "左"
L["Right"] = "右"
L["Typeface"] = "字型"
L["Set the typeface for the stack count and timer text."] = "設置層數和時間文字字型"
L["Text Outline"] = "文本輪廓"
L["Set the outline weight for the stack count and timer text."] = "設置層數和時間文字輪廓"
L["None"] = "無"
L["Thin"] = "細"
L["Thick"] = "粗"
L["Text Size"] = "文字大小"
L["Adjust the size of the stack count and timer text."] = "調整堆疊計數和計時的文字大小。"
L["Max Timer Duration"] = "最大計時期間"
L["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "調整顯示buff或debuff的計時文字，最大的提醒期間，以秒數計。"
L["Show Stance Icons"] = "顯示姿態圖標"
L["Show fake buff icons for monk stances and paladin seals."] = "為武僧姿態以及聖騎士章顯示假造的增益圖標。" -- NEEDS CHECK
L["Show Buff Sources"] = "buff來源"
L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "在提示上顯示buff施放者的名字"
L["Cast by %s"] = "由 %s 施放"
L["Lock Frames"] = "鎖定框架"
L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "鎖定buff和debuff框架,隱藏背景防止被移動"

-- Slash commands
L["lock"] = "鎖定"
L["unlock"] = "解鎖"
L["buff"] = "增益"
L["debuff"] = "減益"
L["Now ignoring buff: %s"] = "現在忽略的buff：%s"
L["Now ignoring debuff: %s"] = "現在忽略的debuff：%s"
L["No longer ignoring buff: %s"] = "不再忽略的buff：%s"
L["No longer ignoring debuff: %s"] = "不再忽略的debuff：%s"
L["No buffs are being ignored."] = "沒有被忽略的buffs。"
L["No debuffs are being ignored."] = "沒有被忽略的debuffs。"
L["%d |4buff:buffs; |4is:are; being ignored:"] = "%d |4buff:buffs;被忽略："
L["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d |4debuff:debuffs;被忽略："

return end