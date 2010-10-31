## PhanxBuffs

**Translations wanted for all locales! If you can help translate, please send me a PM.**

PhanxBuffs is a basic replacement for the default UI’s buff, debuff, and temporary enchant (weapon buff) frames. It looks and acts basically like the default buff frames, with a few improvements:

* Buff and debuff icons are sorted by their remaining duration
* Text timers are shown only when less than 30 seconds remain on the buff or debuff
* Weapon buff icons can show the spell or item that buffed your weapon, instead of the weapon itself
* Buff tooltips show the name of the party or raid member who cast the buff on you
* Buffs or debuffs you never want to see can be hidden (eg. Chill of the Throne)
* Wrap icons to more than one row, with configurable row lengths
* Buff and debuff frames are movable
* Basic configuration options
* ButtonFacade support

## Usage

Options are available by typing `/pbuff` or navigating to the PhanxBuffs panel in the standard Interface Options window.

Add a buff/debuff to the ignore list by right-clicking it while holding down the Alt and Shift keys.

Add/remove a buff/debuff to/from the ignore list by typing `/pbuff buff Zomg Uber Buff` or `/pbuff debuff Zomg Evil Debuff`. Buff/debuff names provided with these commands must be properly spelled, capitalized, and punctuated.

## Buff Cancelling in WoW 4.0

Blizzard added new restrictions on buff cancelling for addons in WoW 4.0. As a result, PhanxBuffs and any other addon which provides a filterable buff display can no longer directly cancel buffs when you right-click on them.

**As a workaround, you can cancel buffs while out of combat by right-clicking on them twice.** The first time you right-click, a red overlay will appear on the buff. Right-click again to cancel the buff, or left-click to hide the overlay and keep the buff. The workaround also supports removing weapon buffs, and removing debuffs your character can dispel.

If you need right-click buff cancelling in combat, try [Aptus Aura Frames](http://wow.curse.com/downloads/wow-addons/details/aptus-af.aspx), [Bison](http://wow.curse.com/downloads/wow-addons/details/bison.aspx), or [NivBuffs](http://www.wowinterface.com/downloads/info18440-nivBuffs.html).

You could also try my new addon [CancelMyBuffs](http://wow.curse.com/downloads/wow-addons/details/cancelmybuffs.aspx), which provides a slightly different way to cancel buffs quickly.

## Localization

PhanxBuffs works in all locales, except for the “show weapon buff sources” feature, which requires translations to function and is currently translated only for English, German, Spanish, French, and Russian clients.

The options text is currently localized in English, French, and Korean.

If you can provide translations for any locale, send me a PM.

## Feature Requests

Please use **[the ticket tracker](http://wow.curseforge.com/addons/phanxbuffs/tickets/?status=+&type=e)** to request features. This keeps all the requests in one place, so they don’t get overlooked or forgotten. Note, however, that PhanxBuffs is intentionally quite basic, and I will probably decline most feature requests, especially requests for more detailed configuration options.

## Bug Reports

Before reporting a bug, please:

1. ... double-check that you have the latest version of PhanxBuffs.
2. ... disable all other addons and see if the problem persists.
3. ... enable Lua error display, or install [!BugGrabber](http://wow.curse.com/downloads/wow-addons/details/bug-grabber.aspx) and [BugSack](http://wow.curse.com/downloads/wow-addons/details/bugsack.aspx), and see if any error messages appear when the problem occurs.

Once you’ve done those things, **[use the bug tracker](http://wow.curseforge.com/addons/phanxbuffs/tickets/?status=+&type=d)** to report the problem. Be sure to include:

* PhanxBuffs version (ex: 4.0.1.50)
* WoW version and locale (ex: 4.0.1 enUS)
* Description of the problem, and steps to reproduce it
* Whether the problem occurs when all other addons are disabled
* Text of any related error messages, WITHOUT lists of local variables or installed addons

Finally, remember to check on your ticket after a few days! I may need more information from you in order to identify and fix the problem.

## License

PhanxBuffs is free as in “free beer”, not as in “free software”, and you may not include it in your compilation, or redistribute it in any other way, without getting permission first. You may, however, reuse code from PhanxBuffs in your own addon. See the LICENSE file inside the addon’s folder for a formal copyright notice and the full license terms under which PhanxBuffs is released.