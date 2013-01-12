PhanxBuffs
==========

* Copyright (c) 2010-2013 Phanx <addons@phanx.net>. All rights reserved.
* See the accompanying LICENSE file for more information.
* http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
* http://www.curse.com/addons/wow/phanxbuffs


Description
-----------

PhanxBuffs is a basic replacement for the default UI’s buff, debuff, and
temporary enchant (weapon buff) frames. It looks and acts basically like
the default buff frames, with a few improvements:

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
-----

Type “/pbuff” for options, or browse to the PhanxBuffs panel in the
standard Interface Options window.

Alt+Shift+Right Click a buff or debuff to add it to the ignore list.

Type “/pbuff buff Zomg Uber Buff” or “/pbuff debuff Zomg Evil Debuff” to
add or remove the specified buff or debuff to or from the ignore list.
Buff/debuff names provided with these commands must be properly spelled,
capitalized, and punctuated.


Cancelling Buffs
----------------

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
------------

Compatible with English, Deutsch, Español (EU & AL), Français, Italiano,
Português, Русский, 한국어, 简体中文, and 繁體中文 game clients.

Translated into English, Español, Français, Português, Русский, 한국어,
and 繁體中文.

To add or update translations for any language, see the Localization tab
on the CurseForge project page:
	<http://wow.curseforge.com/addons/phanxbuffs/localization/>


Feedback
--------

Bugs, errors, or other problems:
	Submit a bug report ticket on either download page.

Feature requests or other suggestions:
	Submit a feature request ticket system on either download page.

General questions or comments:
	Post a comment on the WoWInterface download page.

If you need to contact me privately for a reason other than those listed
above, you can send me a private message on either download site, or
email me at <addons@phanx.net>.