Proof of Work
=============

In a sentence, "If it's good enough to be _peer reviewed_ and put on a retail wiki as fact and _not_ speculation", it's more than good enough. You've done a good job.

What counts as proof?
---------------------

Ideally, you would have a complete packet capture from retail of whatever it is you're implementing, fixing, or updating. This is very important, as sometimes there are conflicting messages that appear to have the same text but aren't identical IDs. For all we know, the text is different for the Japanese client and could be wrong. ![image](https://user-images.githubusercontent.com/60417494/174700353-2d97000d-7362-4161-824d-74e1e31c10cf.png) is not "maybe" to the Japanese client.

What if I can't capture everything?
-----------------------------------

That's fine. We know it's impossible to capture everything all the time. What is important is documenting what you _don't_ know. `TODO:` is not a curse, it helps us know what we need to capture the next time around. We encourage `TODO:` within reason, there are many things that can't be known easily with gargantuan levels of effort required to verify. If something looks like a 100% proc rate but you can't spend weeks gathering the data to figure it out? Put a `TODO:` on it, but we _do_ expect a reasonable effort. 5 samples of something isn't enough.

What if the existing implementation is wrong?
---------------------------------------------

No problem. Mark it as `TODO:` with an applicable message indicating what needs testing. It's not your fault something is what it is, the feature might have changed since it was developed or wasn't tested well enough, possibly even more research revealed that we always had a poor understanding of it. Be sure to reference the most up to date and reliable wiki updated by players who still play the game.

What if I have no idea how (feature) works completely and neither does wiki?
----------------------------------------------------------------------------

You'll need to do your own research or make a discussion about getting research. Note that partial implementations are OK, but you can't just make stuff up. See [#1442](https://github.com/LandSandBoat/server/pull/1442/files#diff-f46ade0c1c56399dea930a6247ae694a8c0d85d6de37db3c0922b87b143cab68)'s foil implementation. Foil's mechanics at the time were unknown, but the spell is still useful as part of the game for enmity purposes.

Levels of certainty required for a "Minimum viable Pull Request":
-----------------------------------------------------------------

### Missions and Quests:

Complete captures for the mission/quest you are implementing are _required_ for correct cutscene events, and parameters. It may not be possible to capture all options on a single character on retail and that's OK. Remember how many options there are to get access to ToAU? You'll need to test that on LSB, not on retail. Do note that wikis are often wrong and they sometimes tell you to skip things you don't need to. We expect you to check all the optional paths _within reason_. Captures also tell us about NPC spawn positions, models, etc. These are critical for a correct implementation of missions, quests, and battlefields.

### Job Mechanics

Captures are required for messages, especially for action packets. Until recently, COR rolls were crashing clients due to the original implementation using only 2 message types, even though there were several more. It's very important to get things right, this way nobody has to revisit a broken implementation, only to change an implementation if/when it is changed in retail. For job mechanics that appear completely unknown and you want to test them, make a discussion! We have plenty of people who've contributed in the past that have tested obscure mechanics and their findings are now the de-facto knowledge of retail until proven otherwise.

### Notorious Monsters

_How am I supposed to know the NM's level?_ Good question! It turns out the widescan packet has all monsters level embedded in it... including Notorious Monsters. This way there's no reversing or guessing and it comes straight from the servers.

About Sourcing
------------

Often content is added using one or more of the fan sites or wiki's as a source. Most of this isn't as trustworthy as you might expect: wiki articles are sometimes getting what they say from the same person across multipel wiki's or obtaining what they say from another wiki, or worse, over google translate and not realizing what translation mistakes have been made.

**Retail packet captures are the end all be all of anything that can be seen in a packet.**

Some things can't be seen in the packets though, and when personally testing and corroborating isn't feasible, we try to find as many online sources as possible to give us a reasonable estimate of what retail does.

Some common data sources are:
* https://www.bg-wiki.com/
* https://ffxiclopedia.fandom.com/
* http://wiki.ffo.jp/
* https://www.ffxiah.com/
* http://ffxidb.com/

Things to remember:
* With crafting we compare ALL recipe sources but ffo.jp has usually been the most reliable.
* With drop rates sample size will influence the values you see on fan sites. ffxidb combines all tiers of Treasure Hunter higher than 2 in the "3+" column and that the "average" column combines all tiers even no TH at all - and so does ffxiclopedia. Further more, due to sample sizes and random variance the rates won't exactly match retail on any site so we look at multiple data points at different TH tiers t make an educated guess about what rarity the item actually is, [based on the chart SE released.](TH-chart)

About Videos
------------

Sometimes, videos are cited as evidence. Some videos are from retail and some are not. Often times on Youtube newer videos of "era" content is done on private servers, and it may be impossible to tell at a glance that it's not retail. Check the channels other videos, comments, video descriptions. Be particularly wary of words like "Classic", as there is no FFXI classic, only private servers that attempt to replicate that.

In closing
----------

We want your contributions and if you need help, please make a discussion. Remember, a `TODO:` doesn't indicate failure to implement, it indicates that we need more information, a much deeper look or backend changes in core.
