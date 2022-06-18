# Laevis

Laevis is a simple gzDoom mod, with high compatibility, where your weapons grow more powerful with use.

Based on the damage you do, weapons will gain stacking damage bonuses, and once you level up enough guns you get permanent bonuses to both the damage you inflict (with every weapon) and your damage resistance.

It also has special support for [Legendoom](https://forum.zdoom.org/viewtopic.php?t=51035), allowing you to earn new effects for your Legendoom weapons by leveling them up, and [Lazy Points](https://forum.zdoom.org/viewtopic.php?f=105&t=66565), with an option to earn XP based on points scored.

All settings are configurable through the gzDoom options menu and through cvars, so you can adjust things like the level-up rate and the amount of bonus damage to suit your taste.

## Installation & Setup

Add `Laevis-<version>.pk3` to your load order. It doesn't matter where.

The first time you play, check your keybindings for "Laevis - Display Info" and, if you're using Legendoom, "Laevis - Cycle Legendoom Weapon Effect" to make sure they're acceptable. You may also want to check the various settings under "Options - Laevis Mod Options".

That's all -- if equipping a weapon and then pressing the "display info" key (default I) in game brings up the Laevis status screen, you should be good to go.

## Legendoom Integration

If you have Legendoom installed, legendary weapons can gain new Legendoom effects on level up. Only one effect can be active at a time, but you can change effects at any time. Weapons can hold a limited number of effects; if you gain a new effect and there's no room for it, you'll be prompted to choose an effect to delete.

When using a Legendoom weapon, you can press the "Cycle Legendoom Weapon Effect" key to cycle through effects, or manually select an effect from the "Laevis Info" screen.

There are a lot of settings for this in the mod settings, including which weapons can learn effects, how rapidly effects are learned, how many effect slots weapons have, etc.

## Lazy Points Integration

To enable this, turn on "Earn XP based on player score" in the mod settings. As long as it's on, you will earn XP equal to the points you score.

This should work with any mod that uses the `pawn.score` property to record points, but Lazy Points is the only one it's actually been tested with.

## FAQ

### Why "Laevis"?

It's named after *Lepidobatrachus laevis*, aka the Wednesday Frog, which consumes anything smaller than itself and grows more powerful thereby.

### What IWADS/mods is this compatible with?

It should be compatible with every IWAD and pretty much every mod. It relies entirely on event handlers and runtime reflection, so as long as the player's guns are still subclasses of `Weapon` it should behave properly. It even works in commercial Doom-engine games like *Hedon Bloodrite*.

Note that weapon bonuses are stored in invisible items in your inventory. This ensures that they are properly written to savegames and whatnot, but also means that anything that takes away your entire inventory will also remove your bonuses, even if "remember missing weapons" is enabled. In particular, if you want to use *Universal Pistol Starter* with this mod but keep your bonuses across maps, you must turn on the "Keep Inventory Items" setting for it.

### Doesn't this significantly unbalance the game in the player's favour?

Yep! You might want to pair it with a mod like *Champions* or *Colourful Hell* to make things a bit spicier, if, unlike me, you are actually good at Doom. (Or you can pair it with *Russian Overkill*, load up Okuplok, and go nuts.)

### Aren't damage/resistance bonuses the most boring kind of upgrades?

Yes, but they're also easy to implement, and for my first Doom mod I wanted to begin with something simple. Time and energy permitting, I do want to add more interesting upgrades to it.

## Known Issues

- If playing with mods that let you drop weapons, the dropped weapons will not remember their levels even once picked back up.
- Mods that allow you to modify or upgrade weapons, such as DRLA, may cause the weapons to reset to level 0 when you do so.
- XP is assigned to the currently wielded weapon at the time the damage is dealt, so it possible for XP to be assigned to the wrong weapon if you switch weapons while projectiles are in flight.
- When using Legendoom, it is possible to permanently downgrade (or, in some cases, upgrade) weapons by changing which effect is active on them before dropping them.

## Future Work

This is not so much a concrete set of plans as an unordered list of ideas I've had for things I might want to add, change, and/or fix.
- More detailed options for when weapon upgrades are forgotten vs. remembered -- when weapon is lost, on level transition, on death, etc.
- HUD rework; use a sprite sheet instead of DrawThickLine()
- Player bonuses other than damage/resistance, like max health, health/armour regeneration up to some level, life/armour leech, extra lives, friendly minions, etc
- Weapon bonuses other than damage, like ammo regeneration up to some level, DoTs of various kinds, exploding shots/corpses, penetrating shots, life/armour/ammo leech, etc
- Dismantle unwanted LD drops to harvest their effects
- Option to give the player XP credit for infighting, etc