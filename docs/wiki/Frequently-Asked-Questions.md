## What works? Is quest X implemented?

We used to keep a document of "What Works?", but maintainers didn't have time to keep it up to date and nobody in the community ever stepped up to help populate it.
Your best bet is always to check the code and fire up the emulator to check in-game.

- [Missions scripts folder](https://github.com/LandSandBoat/server/tree/base/scripts/missions)
- [Quests scripts folder](https://github.com/LandSandBoat/server/tree/base/scripts/quests)
- [Trust scripts folder](https://github.com/LandSandBoat/server/tree/base/scripts/actions/spells/trust)

## How can I help the project?

[How can I help?](How-Can-I-Help)

## Do you have a Discord I can join?

We prefer to work through GitHub [Issues](https://github.com/LandSandBoat/server/issues), [Pull Requests](https://github.com/LandSandBoat/server/pulls), and [Discussions](https://github.com/LandSandBoat/server/discussions).

## Where can I find servers to play on?

Check out the Final Fantasy XI Private Servers Community [List of Servers](https://github.com/XiPrivateServers/Servers/tree/main/servers). You can also head to the [Discord](https://discordapp.com/invite/msACzWV) & [Reddit](https://www.reddit.com/r/FFXIPrivateServers/).

## Is there a GM command that does X?

All available GM commands, with descriptions and the level of GM they require, can be found [here](https://github.com/LandSandBoat/server/tree/base/scripts/commands).

## When will feature X be completed, when will bug Y be fixed?

We practice [clean room engineering](https://en.wikipedia.org/wiki/Clean_room_design), which means we have to implement everything from scratch. As such, progress is slow and difficult. We are also trying to balance feature development, bugfixes, performance improvements, exploit resolution, code review, and testing.

This project is maintained entirely by volunteers in their spare time. We can't and won't ever guarantee any timelines for features or bugfixes. Sometimes the maintainers have lots of time to work on the project, sometimes they have none, sometimes they just don't feel like it and want to go outside and touch grass instead.

The fastest way to get new features or bugfixes is to roll up your sleeves, get in there, and start working on them :)!

## Can I pay someone to implement feature X?

We will never accept financial or material incentives for our work. This is a hobby project. External incentives would drive developer and staff time in a way that makes it no longer a hobby.

## The code for feature X is available in another project or server, why haven't you taken it?

Features in LandSandBoat are those that have been submitted to us, meet our standards for quality and accuracy, and that we have had the time to review and integrate with the rest of the codebase. It is very rare that we will accept code on someone else's behalf. While there is technically nothing stopping us, it would undermine our position in the community.

Similarly, sending us code snippets creates more work and strain on staff and developers. If you have code you want to contribute, please speak to us with GitHub Issues, Discussions, and open a Pull Request.

## Can I use AI to help me write code for LandSandBoat?

Yes, but...

If you submit code written or heavily influenced by AI, you are still responsible for it. That means you understand it, you have tested it, you have implemented it against retail captures and observation, and you have verified it behaves correctly in the official game client. Your code will be read many times over by reviewers and by future contributors. Your pull request, commits,
 code, and research will need to stand up to this scrutiny.

**We can't and won't accept low effort "slop".** A pull request that clearly came straight out of a model with little oversight wastes reviewer time and degrades the codebase. If we suspect a contribution is vibe-coded slop, we will close it without further comment.

Read [`docs/ai_agents/README.md`](https://github.com/LandSandBoat/server/blob/base/docs/ai_agents/README.md) in the server repo before you submit anything. It covers where AI genuinely helps, where it does not, and what we expect from you. It also carries guides for the agents themselves.

## When can I play "Classic" Dynamis?

You can't - it isn't in the game anymore.

<details>
<summary>Read more</summary>
<p>

"Classic" Dynamis was removed from the game in 2011. The spawn mechanisms and mobs as you remember them are gone from the game, and those zones no longer act the way they used to.

The overall project goal is to emulate the retail game as closely as possible, so a massive custom solution to approximate "Classic" Dynamis is not on our roadmap. If a content-complete, balanced, stable, neat, and well-written module becomes available for "Classic" Dynamis, we would consider accepting it.

</p>
</details>

## Can I change job X to play like job Y, Can I create an entirely new job?

No.

<details>
<summary>Read more</summary>
<p>

There are _many many_ things are enforced by the game client.

For instance; you can set your jobs to be 75NIN/75BLM but you won't be able to equip Lv75 BLM gear - this is enforced by the client.

Bypassing these restrictions would need heavy client modification (which we don't support) or support scripts and changes in core.

</p>
</details>

## Why isn't Yell/Trust/Auction House etc. available in every zone?

What's available to use per-zone is controlled with the `misc` flags column in `zone_settings.sql`. These flags correspond to the `ZONEMISC` enum in `zone.h`. A query to modify those flags can be found in [Useful SQL queries](Useful-SQL-queries#enable-zonemisc-features-everywhere).

<details>
<summary>Read more</summary>
<p>

```cpp
enum ZONEMISC
{
    MISC_NONE       = 0x0000,   // Able to be used in any area
    MISC_ESCAPE     = 0x0001,   // Ability to use Escape Spell
    MISC_FELLOW     = 0x0002,   // Ability to summon Fellow NPC
    MISC_MOUNT      = 0x0004,   // Ability to use Chocobos and mounts
    MISC_MAZURKA    = 0x0008,   // Ability to use Mazurka Spell
    MISC_TRACTOR    = 0x0010,   // Ability to use Tractor Spell
    MISC_MOGMENU    = 0x0020,   // Ability to communicate with Nomad Moogle (menu access mog house)
    MISC_COSTUME    = 0x0040,   // Ability to use a Costumes
    MISC_PET        = 0x0080,   // Ability to summon Pets
    MISC_TREASURE   = 0x0100,   // Presence in the global zone TreasurePool
    MISC_AH         = 0x0200,   // Ability to use the auction house
    MISC_YELL       = 0x0400    // Send and receive /yell commands
};
```

</p>
</details>

## Will you accept custom content that doesn't exist on the retail version of the game?

No. We are a retail server emulator.

<details>
<summary>Read more</summary>
<p>

There is a very small set of scenarios where we **might** consider taking in custom content that doesn't demonstrate the same behaviour as on retail FFXI (_these are entirely at our discretion_):
- There is an obvious bug in the retail client that we can easily remedy, ideally toggleable with a setting.
  - Example: Trusts continuing their casting animations if a battle ends while they're in the middle of casting a spell.
- There is content that has been removed, which we can re-add through careful use of modules and settings.
- There is a very easy to tweak magic number we can hook up to a module or setting.

We don't want to become a platform for people to express _what they think_ FFXI is or should be, or what FFXI was during a given time period. This would create lots of extra noise and work, and distract us from emulating the retail game as closely as possible (the version of the game we have access to right now, which also has the most content).

We invite you to make whatever changes you like to your own server, share your code with your friends, and have a good time with the game we all love.

</p>
</details>

## What is Darkstar Project (DSP), Project Topaz (TPZ), or Topaz Next (TPZN)?

These are the predecessor projects that LandSandBoat is derived from, which are archived and no longer maintained or supported.

## Why the strange name? What is a LandSandBoat?

See below: [Why did the airship in Sauromugue Champaign used to skid along the ground like a land speeder?](#why-did-the-airship-in-sauromugue-champaign-used-to-skid-along-the-ground-like-a-land-speeder)

## Why did the airship in Sauromugue Champaign used to skid along the ground like a land speeder?

When incorrectly reading binary data from the database, it caused the airship in Sauromugue Champaign to skate along the ground like an air-hockey puck. It's the project namesake. It's a feature, not a bug. 👀

You can re-enable this using the [lsb_mascot.sql](https://github.com/LandSandBoat/server/blob/base/modules/custom/sql/lsb_mascot.sql) module.
