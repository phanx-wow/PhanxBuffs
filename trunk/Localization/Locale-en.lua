--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
------------------------------------------------------------------------
	English Localization
----------------------------------------------------------------------]]

local L, _, ns = {}, ...
ns.L = L

if not strmatch(GetLocale(), "en") then return end

-- Fake buff tooltip text

L[105361] = "Melee attacks cause Holy damage." -- Seal of Command
L[20165] = "Improves casting speed by 10%.\nImproves healing by 5%.\nMelee attacks have a chance to heal." -- Seal of Insight
L[20154] = "Melee attacks cause Holy damage against all targets within 8 yards." -- Seal of Righteousness
L[31801] = "Melee attacks cause Holy damage over 15 sec." -- Seal of Truth