# Chocobo Raising

```
Dedicated to 'Friend' the Chocobo. RIP.
```

## Notes and Gotchas

- Turn the feature on with `ENABLE_CHOCOBO_RAISING` in `settings/main.lua`.
- `DEBUG_CHOCOBO_RAISING` prints a line per option to the player's chat.
- A player with a GM level of 1 or more can talk to the chocobo next to each trainer to open the
retail developer menu.
- `settings.lua` holds what a server can change: day length, stage days, riding speed and time, stat
  and gil multipliers, `disableRetirement` and `statGrowthCap`.
  `modules/custom/lua/chocobo_raising_qol.lua` shows how to override them safely.
- Bought and ISNM eggs carry no exdata; bred eggs and the debug menu's eggs carry genes.
- Days only advance at the chocobo's own stable; another stable plays a reminder.
- A character holding a Chocobo Whistle is never given the White Handkerchief on day 7.
- Riding needs the Chocobo License.
- Once Mapitoto gives the Chocobo companion, `/mount Chocobo` calls the registered chocobo, as the
  whistle does (`/mount [mount name]` in general).
- The registered chocobo's speed, time and digging stats are fixed at registration; register again
  if they change.
- Run tests: `./xi_test --file chocobo_raising`.

## NPCs

| NPC | Role | Position |
| --- | --- | --- |
| Hantileon | San d'Oria trainer | `!pos -2.675 -0.100 -105.287 230` |
| Zopago | Bastok trainer | `!pos 51.706 0.874 -109.065 234` |
| Pulonono | Windurst trainer | `!pos 130.124 -6.35 -119.341 241` |
| Arvilauge | San d'Oria stable clerk; lost chick clues | `!pos -13.237 1.399 -93.206 230` |
| Gonija | Bastok stable clerk; lost chick clues | `!pos 27.711 0.874 -104.910 234` |
| Kiria-Romaria | Windurst stable clerk; lost chick clues | `!pos 127.687 -5.250 -121.720 241` |
| Finbarr | Breeding: honeymoon tickets and dates | `!pos -52.427 8.199 98.468 244` |
| Mapitoto | The Chocobo companion for a registered whistle | `!pos -54.310 8.200 85.940 244` |
| Dabih Jajalioh | Sells chocobo eggs | `!pos -64.733 12.002 -34.728 243` |

## Useful Items

| Command | Item |
| --- | --- |
| `!additem 2312`, 2314, 2317 | Chocobo eggs, faintly, slightly and a bit warm: bought or from quests |
| `!additem 2318`, 2319 | Chocobo eggs, a little and somewhat warm: from ISNM |
| `!additem 4545 12` | Gysahl Greens |
| `!additem 2339`, `!additem 2342` | Chococard M and F (the debug menu gives them with genes) |
| `!additem 2344` | VCS Honeymoon Ticket |
| `!additem 15533` | Chocobo Whistle |
| `!additem 2366` | Whistle Coupon |
| `!additem 11323`, 11326, 11328 | Purple, Red and Green Racing Silks |
| `!addkeyitem 138` | Chocobo License, needed to ride |
| `!addkeyitem 3055` | Trainer's Whistle, needed by Mapitoto |

## Files

| File | Role |
| --- | --- |
| `chocobo_raising.lua` | Trainer trade, trigger, update and finish handlers |
| `settings.lua` | Values a server may change |
| `constants.lua` | Event ids, cutscenes, enums, care plans, foods, energy costs, stage table |
| `model.lua` | The day model: runs each rollover and returns report records and effects, never touching the player |
| `care_plan.lua` | One day of a care plan, stat changes and the stat cap |
| `condense_events.lua` | Groups days into report records |
| `walks.lua` | Walks, meetings, the lost chick, competing and stories (pure, like the model) |
| `choco_data.lua` | Loads the chocobo, runs the model, applies effects (`xi.chocoboRaising.effect`), saves |
| `event_playout.lua` | Trade, trigger and report cutscene playout |
| `event_vm.lua` | Answers each client option (command in the low byte, argument above); `allowed` guards hidden options |
| `debug_vm.lua` | The developer debug menu |
| `breeding.lua` | Egg genes, colour and sex, chococards, Finbarr |
| `whistle.lua` | Registration, riding speed and time, recharge, coupon, replacement whistles, the registration card |
| `retirement.lua` | Retiring and giving up; card and plaque held for a full inventory |
| `user_data.lua` | Flags and counts that outlive each chocobo |
| `names.lua` | The naming menu's name list |

Storage: `char_chocobos` holds the chocobo being raised. `char_pet.chocobo_user_data` is a 32-byte
blob (`ChocoboUserData_t`) for what outlives it: user flags, eggs handed in, and the registered
chocobo's mount word, digging stats and silks bonus. Char vars hold only state that ends: the
handkerchief and whistle quest until done, the lost chick, held items, Finbarr's egg, debug values.

Tests are in `scripts/tests/systems/chocobo_raising/`, with `client.lua` driving the trainer like
the retail client and `helpers.lua` holding shared model helpers.

## Captured Birds

| Chocobo | Date of Birth |
| --- | --- |
| GFat | 2018-10-19 |
| Cap | 2018-07-05 |
| Friend | 2021-03-20 |
| DunkleKaiser | 2021-07-27 |
| Unnamed chick | 2021-08-20 |
| IrisAudace | 2021-08-22 |
| BlondBrian | 2022-01-14 |

## Sources

Guild Master's Guide tables for food and care plans, as quoted on wiki.ffo.jp:

- https://wiki.ffo.jp/html/10789.html
- https://wiki.ffo.jp/html/10790.html
- https://wiki.ffo.jp/html/10791.html
- https://wiki.ffo.jp/html/7514.html

PlayOnline update notes:

- https://www.playonline.com/pcd/update/ff11us/20060822VOL2B1/detail.html
- https://www.playonline.com/pcd/update/ff11us/20061017UJ0a71/detail.html
- https://www.playonline.com/pcd/update/ff11us/20070606TsVPr1/detail.html
- https://www.playonline.com/pcd/verup/ff11/detail/5334/detail.html
- http://www.playonline.com/pcd/topics/ff11eu/detail/862/detail.html
- http://www.playonline.com/pcd/topics/ff11eu/detail/1100/detail.html

BG Wiki:

- https://www.bg-wiki.com/ffxi/Category:Chocobo_Raising
- https://www.bg-wiki.com/ffxi/Chocobo_Whistle_Quest
- https://www.bg-wiki.com/ffxi/White_handkerchief
- https://www.bg-wiki.com/ffxi/Lost_Chocobo_Chick_Mini-Quest
- https://www.bg-wiki.com/ffxi/Purple_Race_Silks
- https://www.bg-wiki.com/ffxi/Movement_Speed

FFXIclopedia:

- https://ffxiclopedia.fandom.com/wiki/Chocobo_Raising_Guide
- https://ffxiclopedia.fandom.com/wiki/Arael%27s_Chocobo_Raising_Guide
- https://ffxiclopedia.fandom.com/wiki/Chocobo_Raising/Go_on_a_Walk
- https://ffxiclopedia.fandom.com/wiki/Chocobo_Raising/Watch_over_the_Chocobo
- https://ffxiclopedia.fandom.com/wiki/Chocobo_Attributes
- https://ffxiclopedia.fandom.com/wiki/Carnivors_Guide_to_Chocobo_Breeding
- https://ffxiclopedia.fandom.com/wiki/Breeders_Guide_by_Urat
- https://ffxiclopedia.fandom.com/wiki/Chocobo_Whistle
- https://ffxiclopedia.fandom.com/wiki/Chocobo_Whistle_Quest
- https://ffxiclopedia.fandom.com/wiki/White_Handkerchief
- https://ffxiclopedia.fandom.com/wiki/Talk:White_Handkerchief
- https://ffxiclopedia.fandom.com/wiki/Handkerchief
- https://ffxiclopedia.fandom.com/wiki/Dirty_Handkerchief
- https://ffxi.gamerescape.com/wiki/Arael%27s_Chocobo_Raising_Guide (Arael's guide mirror)

Forums and other pages:

- https://wikiwiki.jp/ffxi/アトルガンの秘宝/チョコボ育成
- https://www.ffxiah.com/forum/topic/32770/ninians-guide-to-chocobo-raising-v2/
- https://www.ffxiah.com/forum/topic/57632/chocobo-whistle/
- https://www.ffxiah.com/forum/topic/58501/demystifying-chocobo-raising-plans-and-food/
- https://www.ffxionline.com/forum/ffxi-game-related/crafting-synthesis/chocobo-raising-racing-and-digging/
  (threads 62800, 63439 and 68660)
- https://forum.square-enix.com/ffxi/threads/49059
- https://forum.square-enix.com/ffxi/threads/50584
- https://ffxi.allakhazam.com/wiki/June_2008_Version_Update
- https://game.watch.impress.co.jp/docs/20061013/ff11_11.htm
- https://docs.google.com/spreadsheets/d/1LluCnhI_LTvxW-Q6X6R2i-_jL9TABEbKcGPBMZOOlYU (community
  raising spreadsheet)

## Guesses

Fitted to few samples or taken from guides, with no capture behind them:

- Handkerchief hand-in needs a zone after the next report; none while holding a whistle; a miss
  gives the plain Handkerchief in the search; a search hides at one random walk distance per quest.
  Four captured hand-ins also fit "a report, two Vana'diel midnights, then a zone"
- Energy rank `energy * 2 / 25`; stat ranks of 32 points
- Green Racing Silks taking a tenth off care energy, rounded up (FFXIclopedia; BG says about half and the
  JP wiki gives no figure)
- Sky Blue Racing Silks: a 50% chance per dig of the knowledge message, read as one more skill-up roll
- Care plans: stat changes per arrow, success chance, Basic Care raising a stat 1 day in 6, poor
  days halving, no stat drops from day 64, next-day energy for Exercise Alone and the Interact plans
- The 639 stat cap is our choice, not a guide's: it stops grades at SS/SS/A/F and SS/A/B/C. Guides
  give 637, 640 and 641, and players report retail birds at 640
- Food hunger and affection where no capture covers them: the guide's arrows at 32 hunger and 8
  affection each. Captures fit Gysahl Greens at 104 hunger, wildgrass and adult Vegetable Paste at
  16, Vomp at 96, Cupid Worm at 80, Gregarious Worm at 224, and greens and carrots under 16
  affection. Tornado Salad's single capture gives 64
- Stat arrows, worm stat drops, stat foods' chances, Parasite Worm changing a gene and lowering a
  stat, Worm Paste lowering a chick's stat, a 25% Lethe forget chance (guides say 1 to 7 feedings)
- La Theine Millet is refused, as Little Worm is; no source lists it as food
- Condition onset and end chances (`odds`, `conditionEndOdds`), scene order in a day, a compete
  curing boredom, no affection decay from neglect
- Walk rates: at or below 144 captured walks, mostly their 90% low end (regular walks have few samples);
  the receptivity bonus; some friend chocobo names; an even compete chance; the rivals met only once
- Lost chick: found on the first empty short walk at any stage (3 of 4 captured walks found it; the miss
  was on day 8), once per chocobo and again after a wrong guess; random owner; clues only from the
  four story trainers at the finding stable
- Dietmund needs "Save My Son" and meets a character once
- Story learning 25%, the DSC each ability needs, the inspired stat rise
- Personality: an exact tie gives easygoing; which of DSC and RCP is sensitive. Captures show it
  settling in the chick stage while every stat is under 32, and hint that the plan history drives it
- Adult features need the stat highest and at Average (96)
- Whistle: Canter's 4 minutes, Red Racing Silks' 10 minutes (the JP wiki; a BG talk page test saw 4)
  applied on the whistle only, event 830's variant after a miss, the paid recharge after accepting, buying
  a lost whistle for 20000 gil
- A handkerchief out at give-up or retirement counts as missed; a day away changes nothing;
  registering needs an adult
- Breeding: 5% mutation per gene, ability inheritance at 60% plus 3 per RCP rank, the plans' sire
  and dam lean and male chances, which egg Sports and Hiking lay
- Red and green plaques (311, 313)
- Report details: 248 p5 of 0 running the naming, the replayed retirement record, 246 p3, 244 p5
- Digging: Treasure Finder's second regular roll, RCP and DSC bonuses
- Everything the debug menu does server side (it is developer-only)

## Open Questions

- A chick's overnight hunger drop is fitted to 20 nights (2.25 per point of energy to refill)
- Bastok Watch over froze the client once on a chick in high spirits; note the last text if it
  happens again
- 246 p6 (the server sends 0). Retail sends 260 - 5 * day for eggs, a slow climb for chicks, and 0
  or 355 - 10 * day later. The client never reads it.
- 244 p2 and p3 for chicks and adolescents: retail repeats the last watch, walk or 246 reply
- Personality needs a clear lead on retail, not just a higher stat (a Basic Care test chick turned
  enigmatic at STR 5, END 4, DSC 3, RCP 5)
- The lost chick's retail find chance
- A held found item is lost at retirement or give-up
- Bastok's wrong-guess path and owner events are from the dumps only
- `!chocobo` zeroes the registered digging stats
- Windurst's debug actor 17764444 has no name; check a GM can target it
- A registered player renting a chocobo sees a plain yellow rental
- `/mount Chocobo` (the Chocobo companion from Mapitoto) summons the registered bird
- Finbarr's events 10101 (long introduction) and 10103 (one line) never play; no capture shows
  a first meeting
- Finbarr's reply when the egg is ready and the inventory is full: 10107 has no inventory
  branch, so probably 10107 and then `ITEM_CANNOT_BE_OBTAINED`
- The message for using the whistle without a license; the client DATs have no specific one

## TODO

- Test in the live client: Victoire's lost chick question (event 848, from the dumps only), the
  kept-greens message, and vitality and intelligence starting only in adolescents
- Weather in zones on another map process: `getWeatherInZone` returns `xi.weather.NONE` for them.
  Walk events and other weather checks need an IPC query for it
- Lost chick owners inside guild events, decoded from the dumps:
  - Abd-al-Raziq (120), Ponono (10011), Peshi Yohnts (10016): start p4 bits 11-12 set to 1 (owner)
    or 2 (not the owner); "Yes" adds 5 to the finish option
  - Azima (541 in place of 122), Kyaa Taali (763 in place of 10020): "Yes" sets option bit 2; the
    update reply's p6 is 1 for the owner
  - Kopuro-Popuro (24 guild events): reply p4 of 1 to the option 2 update shows the question; "Yes"
    sends option 100 and a reply p4 of 1 means the owner
- Energy on a Rest day: 100 for a chick, 66 for an adolescent and 41 for an adult in one capture
  each; the next day reads 100 - that plan's cost
- A pending quest whistle for a player with no chocobo and no registration card: event 844 with
  mask 0x7FFFFFFE fits the bytecode
- Loneliness only in chocobos the player visits
- Digging: weather preference, STR on beastman supplies, the 2016 zones
  that need a personal chocobo
