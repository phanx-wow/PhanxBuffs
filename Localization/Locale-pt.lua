--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
------------------------------------------------------------------------
	Portuguese Localization (Português)
	Last updated 2014-08-27 by Tercioo
----------------------------------------------------------------------]]

if GetLocale() ~= "ptBR" then return end
local _, ns = ...
ns.L = {

-- Fake buff tooltip text

	[105361] = "Ataques corpo a corpo causam dano Sagrado.", -- Selo da Retidão
	[20165] = "Aumenta em 10% a velocidade de lançamento.\nMelhora em 5% a cura.\nAtaques corpo a corpo podem curar.", -- Selo da Intuição
	[20154] = "Ataques corpo a corpo causam dano Sagrado contra todos os alvos em um raio de 8 metros.", -- Selo da Retidão
	[31801] = "Ataques corpo a corpo causam dano Sagrado ao longo de 15 s.", -- Selo da Verdade

-- Broker tooltip

--	["Click to lock or unlock the frames."] = "",
--	["Right-click for options."] = "",

-- Configuration panel

	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "Estas opções permitem alterar algumas configurações básicas para os ícones de bônus, penalidades, e encantamentos de armas.",

	["Buff Size"] = "Tamanho dos bônus",
	["Adjust the size of each buff icon."] = "Alterar o tamanho de cada ícone de bônus.",
	["Buff Spacing"] = "Espaçamento dos bônus",
	["Adjust the space between buff icons."] = "Alterar o espaço entre ícones de bônus.",
	["Buff Columns"] = "Colunas dos bônus",
	["Adjust the number of buff icons to show on each row."] = "Alterar o número de ícones de bônus para mostrar em cada linha.",
	["Buff Anchor"] = "Ponto inicial dos bônus",
	["Choose whether the buff icons grow from left to right, or right to left."] = "Escolher se estender os ícones de bônus de direita a esquerda, ou de esquerda a direita.",
	["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "Escolher se estender os ícones de bônus de topo a fundo, ou de fundo a topo.",

	["Debuff Size"] = "Tamanho das penalidades",
	["Adjust the size of each debuff icon."] = "Alterar o tamanho de cada ícone de penalidade.",
	["Debuff Spacing"] = "Espaçamento das penalidades",
	["Adjust the space between debuff icons."] = "Alterar o espaço entre ícones de penalidades.",
	["Debuff Columns"] = "Colunas dos bônus",
	["Adjust the number of debuff icons to show on each row."] = "Alterar o número de ícones de penalidades para mostrar em cada linha.",
	["Debuff Anchor"] = "Ponto inicial dos bônus",
	["Choose whether the debuff icons grow from left to right, or right to left."] = "Escolher se estender os ícones de penalidades de direita a esquerda, ou de esquerda a direita.",
	["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "Escolher se estender os ícones de penalidades de topo a fundo, ou de fundo a topo.",

	["Top"] = "Topo",
	["Bottom"] = "Fundo",
	["Left"] = "Esquerda",
	["Right"] = "Direita",

	["Typeface"] = "Tipo de letra",
	["Set the typeface for the stack count and timer text."] = "Escolher o tipo de letra para o texto da contagem de aplicação e tempo restante.",
	["Text Outline"] = "Contorno do texto",
	["Set the outline weight for the stack count and timer text."] = "Escolher a espessura da linha de contorno para o texto da contagem de aplicação e tempo restante.",
	["None"] = "Nenhum",
	["Thin"] = "Fino",
	["Thick"] = "Espesso",
	["Text Size"] = "Tamanho do texto",
	["Adjust the size of the stack count and timer text."] = "Ajustar o tamanho do texto da contagem de aplicação e tempo restante.",

	["Max Timer Duration"] = "Duração máxima da cronometrista",
	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "Alterar o máximo de tempo restante, em segundos, para mostrar o texto de tempo para um bônus ou penalidade.",

	["Show Stance Icons"] = "Mostrar ícones de posturas",
	["Show fake buff icons for monk and warrior stances and paladin seals."] = "Mostrar auras representando posturas de guerreiros e monges e selos de paladinos.",
	["Buff Sources"] = "Origens dos bônus",
	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "Mostrar na dica o nome do membro do grupo que aplicou em você o bônus.",
	["One-Click Cancel"] = "Só clique para cancelar",
	["Cancel unprotected buffs on the first click, instead of the second. Only works out of combat, and protected buffs like shapeshift forms and weapon buffs will still require two clicks."] = "Cancelar bónus desprotegidos no primeiro clique, em vez do segundo. Isso só funciona fora de combate, e bônus protegidas como formas e encantamentos de armas ainda requerem dois cliques.",
	["Lock Frames"] = "Travar ícones",
	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "Travar os ícones no lugar e esconder o fundo.",

	["Cast by %s"] = "Aplicada por %s",

-- Slash commands

--	["lock"] = "",
--	["unlock"] = "",
	["buff"] = "bônus",
	["debuff"] = "penalidade",
	["Now ignoring buff: %s"] = "Agora ignorando o bônus: %s",
	["Now ignoring debuff: %s"] = "Agora ignorando o penalidade: %s",
	["No longer ignoring buff: %s"] = "Já não ignorando o bônus: %s",
	["No longer ignoring debuff: %s"] = "Já não ignorando o penalidade: %s",
	["No buffs are being ignored."] = "Não há bônus são ignorados.",
	["No debuffs are being ignored."] = "Não há penalidades são ignoradas.",
	["%d |4buff:buffs; |4is:are; being ignored:"] = "%d bônus |4é:são; |4ignorada:ignoradas;:",
	["%d |4debuff:debuffs; |4is:are; being ignored:"] = "%d |4penalidade:penalidades; |4é:são; |4ignorada:ignoradas;:",

}