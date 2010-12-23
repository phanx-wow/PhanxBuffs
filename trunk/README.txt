# PhanxBuffs

* by Phanx < addons@phanx.net >
* Currently maintained by Akkorian < akkorian@hotmail.com >
* Copyright © 2010 Phanx. Some rights reserved. See LICENSE.txt for details.
* http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
* http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx


## Description

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


## Usage

Options are available by typing "/pbuff" or navigating to the PhanxBuffs
panel in the standard Interface Options window.

Add a buff/debuff to the ignore list by right-clicking it while holding
down the Alt and Shift keys.

Add/remove a buff/debuff to/from the ignore list by typing
"/pbuff buff Zomg Uber Buff" or "/pbuff debuff Zomg Evil Debuff".
Buff/debuff names provided with these commands must be properly spelled,
capitalized, and punctuated.


## Buff Cancelling in WoW 4.0

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


## Localization

PhanxBuffs is compatible with English, Deutsch, Español, Français,
Русский, 한국어, and 正體中文 game clients.

The options text is currently translated into English, Français, 한국어,
and 正體中文. If you can provide translations for any locale, please send
me a PM on either download site.


## Feedback

For bug reports and feature requests, please use the ticket tracker on
either download site. For general questions and comments, post a ticket
on either download site.

If you need to contact me privately, send me a PM on either download
site, or email me at akkorian@hotmail.com or addons@phanx.net.