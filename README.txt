PhanxBuffs
==========

* Copyright (c) 2010-2012 Phanx <addons@phanx.net>. All rights reserved.
* See the accompanying LICENSE file for more information.
* http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
* http://www.curse.com/addons/wow/phanxbuffs


Description
-----------

PhanxBuffs is a basic replacement for the default UI’s buff, debuff, and
temporary enchant (weapon buff) frames. It looks and acts basically like
the default buff frames, with a few improvements:

* Buff and debuff icons are sorted by their remaining duration
* Text timers are shown only when less than 30 seconds remain on the
  buff or debuff
* Weapon buff icons can show the spell or item that buffed your weapon,
  instead of the weapon itself
* Buff tooltips show the name of the party or raid member who cast the
  buff on you
* Buffs or debuffs you never want to see can be hidden (eg. Chill of the
  Throne)
* Wrap icons to more than one row, with configurable row lengths
* Buff and debuff frames are movable
* Basic configuration options
* ButtonFacade support


Usage
-----

Options are available by typing "/pbuff" or navigating to the PhanxBuffs
panel in the standard Interface Options window.

Add a buff/debuff to the ignore list by right-clicking it while holding
down the Alt and Shift keys.

Add/remove a buff/debuff to/from the ignore list by typing
"/pbuff buff Zomg Uber Buff" or "/pbuff debuff Zomg Evil Debuff".
Buff/debuff names provided with these commands must be properly spelled,
capitalized, and punctuated.


Buff Cancelling in WoW 4.0 (Cataclysm)
--------------------------------------

Due to Blizzard restrictions, PhanxBuffs and other addons which provide
a filterable buff display can no longer directly cancel buffs when you
right-click on them.

As a workaround, you can cancel buffs by right-clicking them twice, but
only while out of combat. The first right-click will bring up a red
overlay on the buff icon. Right-click again to cancel the buff, or
left-click to hide the overlay and keep the buff.

If you need right-click buff cancelling in combat, keep in mind that you
will have to sacrifice most filtering and sorting functions. Here are
several addons that use the restrictive new secure aura system:

* Aptus Aura Frames
  http://www.wowinterface.com/downloads/info18102-AptusAuraFrames.html
* Bison
  http://www.wowace.com/addons/bison/
* NivBuffs
  http://www.wowinterface.com/downloads/info18440-nivBuffs.html

You may also try my new addon CancelMyBuffs, which provides a slightly
different way to cancel buffs quickly:

* http://www.wowinterface.com/downloads/info18447-CancelMyBuffs.html


Localization
------------

Compatible with English, Deutsch, Español (EU), Español (AL), Français,
Português, Русский, 한국어, 简体中文, and 繁體中文 game clients.

Translated into English, Français, 한국어, and 繁體中文.

To add or update translations for any language, see the Localization tab
on the CurseForge project page:

http://wow.curseforge.com/addons/phanxbuffs/localization/


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