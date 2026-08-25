**TLDR:**
>- The main destructive changes we've been working on at LandSandBoat are complete!
>- Up to 20x performance improvement*!
>- **ZERO** runtime file reads for scripting, down from 100-300 per second!
>- Stats: 13838 files changed (lines: +111,537, −75,698), 381 commits in one month! 
>- `canary` branch is back and is the test environment for the refactor!
>- Contributions are OPEN again!
>
>_* In some hot-path areas, forgive me for the clickbait!_

## Introduction
Towards the end of Project Topaz, we were planning on writing a nice "year in review" article presenting all of the things we had developed and released with the community's help over the past year. Unfortunately, Project Topaz folded and I don't feel like it's appropriate to present that type of article now that we're operating under a different name. Alongside this article, we had proof of concepts and early implementations of important architectural work that was almost ready to roll out. Since then we've entirely rewritten that work and taken it to completion!

## The PR
<https://github.com/LandSandBoat/server/pull/2288>

**Summary:**
> We've gutted the entire system that links C++ to Lua, replacing it with the excellent Sol framework

There are a lot of things enabled by this work that might not be easily digestible by non-developers, so this article is an attempt to explain why this work has taken priority over everything else, and why you'll soon be reaping the benefits!

This work was originally planned to be executed over the course of 2x 6-week stages, but the first stage was so successful we rolled the second one into it to deliver them together. 

I'd also like to extend my extreme thanks to Wren and claywar; for absolutely annihilating any estimates I had for when this work would be complete. We're literally _months_ ahead of schedule because of their bonkers work ethics! Also a special thanks to the few brave souls who were willing to test the refactor work as it went on, you've helped us shake out a lot of bugs!

## Background

We use Lua (Portuguese for Moon, not an acronym) as a scripting language for quick iteration, and to lower the barrier to entry for newcomers. Aside from a couple of quirks that get under peoples' skin (1-indexed arrays); it is a wonderful language that is very fast to pick up and has surprising versatility.

In order to use Lua alongside our Core C++ code, we need to `bind` C++ functions to Lua, and represent `C++ Types` as `Lua Usertypes`. This is achieved by using a `binding system`, or `binding library`. 

Our old binding system was called [Lunar](http://lua-users.org/wiki/CppBindingWithLunar) and was originally published as a code snippet around 2009. At the time, there probably wasn't much available in terms of binding libraries, so this would have been a godsend in terms of "easy" interop with C++. Unfortunately, Lunar hasn't been upgraded or iterated on... ever. We haven't touched it (apart from formatting passes) since [Sep 16, 2011](https://github.com/LandSandBoat/server/commit/7a160120a7b7313cbfc1b5483627cebc24776ada#diff-605911436f6554e7f7420de334e67cd1d76100e8c8f33559c4d9733db3011b70).

If it was rock-solid and easy to use/understand/extend, then we would be perfectly fine to leave it alone forever. This, however, is not the case. The binding system and the process of getting information into and out of the Lua state is fragile and arcane. Much developer time has been wasted "fiddling with the stack". Since our adoption of Lunar pre-2011, the Lua-binding ecosystem has moved on and there are a wealth of viable libraries allowing for safer usage, modern workflows, and easier to understand/maintain code.

The most promising and well supported library at the moment is **[sol](https://github.com/ThePhD/sol2)** (sol2 v3, referred to as Sol/sol for clarity).

## Goals

### Runtime Safety
<img src="https://user-images.githubusercontent.com/1389729/103868903-38b9ff80-50d2-11eb-985d-cf0e567ae285.png" width="600" height="300" />

Unless handled very carefully, if an error is encountered in C++; it will kill the server. Unless you're debugging or you're set up correctly to capture crash information this crash will be difficult to diagnose. Even if you catch the crash, it can be hard to understand or fix unless you're comfortable with C++.

If an error is encountered in Lua it will log all the information it has and then bail out of the current script; allowing the C++ execution to continue underneath it, leaving the server alive.

The more errors we can catch in the Lua layer before they make it into C++, the less crashes there'll be. 

An added benefit of using Sol is that it validates the use of bindings at the Lua level. If you call `mob:takeDamage(x)`, but `mob` or `x` are nil/invalid; it won't make it into the C++. It'll log an error and operation will continue.

### Runtime Performance
<img src="https://user-images.githubusercontent.com/1389729/103868923-41aad100-50d2-11eb-80b7-abd2f6d29afa.png" width="600" height="300" />

Every time a script is run (for the most part) it will be freshly read off the disk, regardless of if it has been read before. You can read about the comp-sci details [here](https://en.wikipedia.org/wiki/Memory_hierarchy), but briefly; reading a file off disk is much much slower than reading it from memory. Every Player, NPC, and Mob who is currently active will be constantly calling and loading Lua scripts from the disk. The performance cost of this adds up very quickly and can get out of hand, rendering your server unresponsive. Using an SSD or other high-performance storage can ease the load a bit, but doesn't erase the issue.

With the new design, scripts are read once at startup, and their various function calls are cached in memory. This leads to a very significant improvement in lookup and execution time:

<img src="https://user-images.githubusercontent.com/1389729/104956773-7de50800-59d5-11eb-9c4a-7aa67a68bc4d.png" width="600" height="500" />
</br>
<img src="https://user-images.githubusercontent.com/1389729/104839710-8f41ed80-58cb-11eb-8d5a-500d6f3c3216.png" width="700" height="400" />
</br>
<img src="https://user-images.githubusercontent.com/1389729/103680388-c8ef2c00-4f8e-11eb-8632-f589d0d9f9b6.png" width="400" height="300" />
</br>

`The fabled 20x performance improvement`

_This work was/is possible without using Sol, and was prototyped without it, but that was MUCH harder to pull off. It was made nearly trivial to implement by leaning on Sol._

**Memory Impact**

In the grand scheme of the entire program, our overall Lua memory usage has gone up from 6mb to 28mb per instance. An instance is already running at 700-1000mb usage, so this isn't much of an impact considering the performance gains.

**Live reloading scripts**

The one benefit of the old system was the ability to hot-swap and modify scripts on-the-fly. If it's being read all the time, any changes you make will get picked up and used immediately - leading to a very short iteration cycle. This is a feature we absolutely couldn't have dropped, it's vital for anyone wanting to write scripts. We've kept this functionality by adding a `FileWatcher`; this will inform the server process if anything in the `scripts/` folder has changed during operation and re-cache it. This functionality is enabled by default for Debug builds, and disabled in Release builds.

```
[FileWatch] Modifiy: ./scripts/zones/South_Gustaberg/mobs/Tococo.lua
[FileWatch] Caching: xi.zones.South_Gustaberg.mobs.Tococo
```

### Developer Quality of Life
<img src="https://user-images.githubusercontent.com/1389729/103868938-47a0b200-50d2-11eb-8557-c4c3b9319cfe.png" width="600" height="300" />

All interaction between Lua and C++ before was handled manually. You would have to push and pull items off of the Lua stack, make sure you left the stack in a sane state when you were done, constantly query the state of the stack, register function pointers, validate all arguments coming in and out of your bindings etc. It was scary for newcomers, and never got any less fiddly or fragile for people who were familiar with it.

Using Sol to handle C++/Lua interop is the difference between trying to clean your living-room floor with a blowtorch, or turning on your Roomba. It's a night-and-day difference.

## What does this mean for my server?
This is a huge breaking change. Every single binding has been rewritten, every single script has been modified. We recommend you take our repo and re-apply your custom changes over the top of it. Unless you have more time than sense, you won't be able to merge this into your current branches.

If you have custom bindings, there should be enough examples of the new style to allow you to convert them without much effort.

## Small Warning
Does this mean calling Lua is faster, easier, and more efficient? Yes. Absolutely. 

Does this mean we should start cramming everything into Lua indiscriminately? **No.** Lua, Luajit (our fast version of Lua), and Sol are wonderful tools, but they are not a replacement for the sheer heavy lifting power of C++, or the storage/querying power of SQL. This work doesn't turn on some kind of "everything should be in Lua now" switch. Make the same choices you would have before so that we can use these performance gains to carry the project into the future!

## What's Next?

We have a few other projects in the planning stages that should double overall zone performance again, and they aren't as drastic as this refactoring, so look forward to that :)

## Other Goodies
Content contributions are now OPEN*! 🎉

_***Please** keep in mind we're still a small crew, and one of the reasons Project Topaz folded was the stress of constantly bending over backwards to please contributors._

This work enables basic Lua modules. If you know what you're doing, you can start writing them _today_ by overwriting cache entries. If you're not sure, we'll have some small examples out sometime soon.

### Help?
If you are going to undertake a similar process to this, we've captured some of the more insidious gotchas in the [Lua gotchas page](Lua-Guide-and-Gotchas).

## Licensing

This work is licensed under [GNU General Public License v3.0](https://github.com/LandSandBoat/server/blob/release/LICENSE), the same license as everything else. Please use it with our blessing!
