PhanxBuffs
=============

* [WoWInterface](http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html)
* [Curse](http://www.curse.com/addons/wow/phanxbuffs)


Description
--------------

Basic replacement for the default UI’s buff, debuff, and temporary
enchant (weapon buff) frames. It looks and acts basically like the
default buff frames, with a few improvements:

* Buff and debuff icons are sorted by their remaining duration
* Text timers are shown only when less than 30 seconds remain
* Weapon buff icons can show the spell or item that buffed your weapon,
  instead of the weapon itself
* Buff tooltips show the name of the group member who cast it on you
* Buffs or debuffs you never want to see can be hidden
* Wrap icons to more than one row, with configurable row lengths
* Buff and debuff frames are movable
* Basic configuration options
* Masque skinning support


Usage
--------

Type “/pbuff” for options, or browse to the PhanxBuffs panel in the
standard Interface Options window.

Alt+Shift+Right Click a buff or debuff to add it to the ignore list.

Type “/pbuff buff Zomg Uber Buff” or “/pbuff debuff Zomg Evil Debuff” to
add or remove the specified buff or debuff to or from the ignore list.
Buff/debuff names provided with these commands must be properly spelled,
capitalized, and punctuated.


Cancelling Buffs
-------------------

Due to Blizzard restrictions, you cannot right-click to cancel buffs
while in combat when using addons that filter or sort the buff display.
PhanxBuffs includes a workaround that lets you right-click to cancel
buffs *out of combat*, but you must click twice to remove certain
“protected” buffs like shapeshift forms and weapon buffs. By default,
PhanxBuffs applies this two-click cancelling method to all buffs to keep
things consistent, but if you like, you can enable one-click cancelling
for unprotected buffs in the options panel.

When you right-click once, a red square will appear over the buff icon.
Right-click again to cancel the buff, or left-click to keep it and hide
the red square. You can also right-click on debuffs your character can
dispel to cast the appropriate dispel spell on yourself, but as with
cancelling buffs, this feature only works out of combat.


Localization
---------------

Compatible with all localized game clients.

Translated into English, Español, Français, Português, Русский,
한국어 and 繁體中文.

You can add or update translations on the [CurseForge project page] [1].

	[1]: http://wow.curseforge.com/addons/phanxbuffs/localization/


Feedback
-----------

Post a ticket on either download site, or a comment on WoWInterface.

If you are reporting a bug, please include directions I can follow to
reproduce the bug, whether it still happens when all other addons are
disabled, and the exact text of the related error message (if any) from 
[BugSack](http://www.wowinterface.com/downloads/info5995-BugSack.html).

If you need to contact me privately, you can send me a private message
on either download site, or email me at <addons@phanx.net>.


License
----------

Copyright (c) 2010-2014 Phanx. All rights reserved.  
See the accompanying LICENSE file for information about the conditions
under which redistribution and modification may be allowed.
