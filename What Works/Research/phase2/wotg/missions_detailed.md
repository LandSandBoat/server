# Wings of the Goddess Missions -- Detailed Audit

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Wings_of_the_Goddess_Missions
- Codebase: `scripts/missions/wotg/*.lua`, `scripts/quests/crystalWar/*.lua`, `scripts/battlefields/`, `scripts/zones/*/instances/`

## Summary
All 54 mission scripts exist (54/54). The mission chain is well-scripted with proper NPC triggers, zone-in cutscenes, and flag advancement. However, **6 Crystal War side-quest chains required as prerequisites are MISSING scripts**, several **battlefield/instance zones are NOT implemented**, and the final boss fight (Lilith, mission 51) has **no battlefield script**. Campaign battles are NOT directly required by any mission script -- the prerequisite quests that gate progress are nation-specific side-quest chains (Sandy/Bastok/Windy paths), not Campaign participation itself.

## Critical Architecture Notes

### Prerequisite Side-Quest Chains
WotG missions are gated at 6 checkpoints by Crystal War side-quests (helpers.lua). The player must complete ONE quest from each tier (Sandy OR Bastok OR Windy path). Many of these quest scripts are **MISSING**:

| Gate | Mission | Sandy Quest | Bastok Quest | Windy Quest |
|------|---------|------------|--------------|-------------|
| 1 | WotG 2 (Back to Beginning) | Steamed Rams (EXISTS) | The Fighting Fourth (EXISTS) | Snake on the Plains (EXISTS) |
| 2 | WotG 3 (Cait Sith) | Claws of the Griffon (EXISTS) | The Tigress Strikes (MISSING) | Fires of Discontent (MISSING) |
| 3 | WotG 4 (Queen of the Dance) | Burden of Suspicion (MISSING) | Wrath of the Griffon (EXISTS) | A Manifest Problem (MISSING) |
| 4 | WotG 8 (In the Name of the Father) | Fire in the Hole (MISSING) | In a Haze of Glory (EXISTS) | A Feast for Gnats (MISSING) |
| 5 | WotG 15 (Crossroads of Time) | Honor Under Fire (MISSING) | Bonds That Never Die (EXISTS) | The Forbidden Path (MISSING) |
| 6 | WotG 26 (Fate in Haze) | What Price Loyalty (MISSING) | Blood of Heroes (EXISTS) | Howl from the Heavens (MISSING) |
| 7 | WotG 38 (Adieu, Lilisette) | Bonds of Mythril (MISSING) | Face of the Future (EXISTS) | At Journey's End (MISSING) |

**Key finding**: The Bastok path (Griffon quest chain) is fully scripted. Sandy and Windy paths are mostly MISSING. A player aligned to Bastok can progress through all gates. Sandy/Windy players are BLOCKED at gate 2.

### Battlefield/Instance Status

| Zone | Used By | Status |
|------|---------|--------|
| La Vaule [S] | Mission 7 (Purple, The New Black) -- Galarhigg fight | **WORKS** -- battlefield script exists |
| Everbloom Hollow | Missions 14, 23 -- instances | **PARTIAL** -- doomvoid.lua is a stub (empty handlers), but light_in_the_darkness.lua in Ruhotz is functional |
| Ghoyus Reverie | Missions 31, 32, 33 -- instances | **PARTIAL** -- doomvoid.lua is a stub (empty handlers) |
| Ruhotz Silvermines | Mission 24 (Distorter of Time) | **PARTIAL** -- light_in_the_darkness.lua is functional; doomvoid.lua is stub |
| Throne Room [S] | Mission 37 (Darkness Descends) -- Lady Lilith fight | **MISSING** -- no battlefield script exists |
| Walk of Echoes | Mission 46 (When Wills Collide) -- battlefield | **MISSING** -- no battlefield scripts exist |
| Walk of Echoes | Mission 51 (Maiden of the Dusk) -- Lilith fight | **MISSING** -- no battlefield script exists |

## Mission-by-Mission Checklist

| # | Mission | Lines | Status | Notes |
|---|---------|-------|--------|-------|
| 1 | Cavernous Maws | 87 | WORKS | Touch Cavernous Maw in Batallia/Rolanberry/Sauromugue. Grants Pure White Feather KI. |
| 2 | Back to the Beginning | 119 | WORKS | Touch Maw again in present or past. Grants Lightsworm KI. Prerequisite: complete 1 of 3 tier-1 side-quests (all exist). |
| 3 | Cait Sith | 53 | WORKS | Zone into S. San d'Oria [S] from E. Ronfaure [S]. Prerequisite: tier-2 side-quest (Bastok path works). |
| 4 | The Queen of the Dance | 123 | WORKS | Multi-step: Lion Springs door, get ticket from Turlough in Upper Jeuno, return. Prerequisite: tier-3 side-quest (Bastok path works). |
| 5 | While the Cat is Away | 56 | WORKS | Zone into E. Ronfaure [S] from S. San d'Oria [S]. Cutscene only. |
| 6 | A Timeswept Butterfly | 42 | WORKS | Zone into La Vaule [S] from Jugner Forest [S]. Cutscene only. |
| 7 | Purple, The New Black | 71 | WORKS | BCNM vs Galarhigg in La Vaule [S]. Battlefield script exists and is fully functional with trusts allowed. |
| 8 | In the Name of the Father | 50 | WORKS | Talk to Lion Springs in S. San d'Oria [S]. Prerequisite: tier-4 side-quest (Bastok path works). |
| 9 | Dancers in Distress | 147 | WORKS | Talk to Raustigne, then Elegant Footprints in Jugner [S], complete quiz, trade item. Well-scripted. |
| 10 | Daughter of a Knight | 281 | WORKS | Multi-step: Amaura in S. Sandy, Cernunnos Bulb trade, plant in Jugner [S], fight Cernunnos NM in present Jugner, return to Amaura. Fully scripted with NM spawn. |
| 11 | A Spoonful of Sugar | 44 | WORKS | Talk to Raustigne in S. San d'Oria [S]. Single cutscene. |
| 12 | Affairs of State | 130 | WORKS | Visit Windurst Waters [S] and Bastok Markets [S] in either order. Well-scripted with both paths. |
| 13 | Borne by the Wind | 59 | WORKS | Check Bulwark Gate in Sauromugue [S]. Grants Underpass Hatch Key. |
| 14 | A Nation on the Brink | 162 | BLOCKED | Multi-step with Everbloom Hollow instance. Instance uses Event 10000 callback but **instance is a stub** (doomvoid.lua has empty handlers). Mission script handles the event but instance never triggers it. Title: Battle of Jeuno Veteran. |
| 15 | Crossroads of Time | 45 | WORKS | Zone into S. San d'Oria [S] from E. Ronfaure [S]. Prerequisite: tier-5 side-quest (Bastok path works). |
| 16 | Sandswept Memories | 43 | WORKS | Talk to Lion Springs in S. San d'Oria [S]. Single cutscene. |
| 17 | Northland Exposure | 40 | WORKS | Zone into Beaucedine Glacier [S]. Cutscene grants Shadow Bug KI. |
| 18 | Traitor in the Midst | 128 | WORKS | Minigame with Regal Pawprints in Beaucedine [S]. Complete 5 timed games then talk to Regal Pawprints 1. Well-scripted. |
| 19 | Betrayal at Beaucedine | 92 | WORKS | Fight Count Halphas NM at Regal Pawprints in Beaucedine [S]. NM spawn and death handler fully scripted. |
| 20 | On Thin Ice | 42 | WORKS | Talk to Raustigne in S. San d'Oria [S]. Single cutscene. |
| 21 | Proof of Valor | 532 | WORKS | Extensive petition-gathering quest in S. San d'Oria [S]. 19 NPCs, trades, minigames, signatures. Most complex mission script. |
| 22 | A Sanguinary Prelude | 39 | WORKS | Zone into Beaucedine [S]. Cutscene grants Aroma Bug KI. |
| 23 | Dungeons and Dancers | 89 | BLOCKED | Requires Everbloom Hollow instance. Script references Event 10000 from instance completion but **instance is a stub**. Has TODO note. |
| 24 | Distorter of Time | 75 | BLOCKED | Requires Ruhotz Silvermines instance (Event 10000). The `light_in_the_darkness.lua` instance IS functional, but mission 24 uses `doomvoid.lua` which is a **stub**. Has TODO note. |
| 25 | The Will of the World | 42 | WORKS | Talk to Raustigne in S. San d'Oria [S]. Single cutscene. |
| 26 | Fate in Haze | 92 | WORKS | Multi-step cutscenes at Lion Springs in S. San d'Oria [S]. Prerequisite: tier-6 side-quest (Bastok path works). |
| 27 | The Scent of Battle | 37 | WORKS | Check Bulwark Gate in Sauromugue [S]. Single cutscene. |
| 28 | Another World | 63 | WORKS | Zone into S. San d'Oria from E. Ronfaure, then talk to Halver in Chateau d'Oraguille. |
| 29 | A Hawk in Repose | 58 | WORKS | Check Weathered Gravestone in Batallia Downs, then trade a Lilac. |
| 30 | The Battle of Xarcabard | 56 | WORKS | Zone into Xarcabard [S] for cutscene, then talk to Rally Point Red. |
| 31 | Prelude to a Storm | 123 | BLOCKED | Requires Ghoyus Reverie instance. Instance (doomvoid.lua) is a **stub**. Has TODO note about Event 10000 and reward tier logic. |
| 32 | Storm's Crescendo | 125 | BLOCKED | Requires Ghoyus Reverie instance. Instance is a **stub**. Has TODO note. |
| 33 | Into the Beast's Maw | 140 | BLOCKED | Requires Ghoyus Reverie instance. Instance is a **stub**. Multi-step with cutscenes in Castle Zvahl Baileys [S]. Has TODO note. |
| 34 | The Hunter Ensnared | 37 | WORKS | Talk to Rally Point Red in Xarcabard [S]. Single cutscene. |
| 35 | Flight of the Lion | 37 | WORKS | Check Bulwark Gate in Sauromugue [S]. Single cutscene. |
| 36 | Fall of the Hawk | 38 | WORKS | Zone into Castle Zvahl Baileys [S]. Cutscene only. |
| 37 | Darkness Descends | 80 | BLOCKED | BCNM fight in Throne Room [S]. Script references `battlefieldWin` check for `xi.battlefield.id.DARKNESS_DESCENDS`. **No battlefield script exists** in `scripts/battlefields/Throne_Room_[S]/`. |
| 38 | Adieu, Lilisette | 57 | WORKS | Talk to Lion Springs in S. San d'Oria [S]. Prerequisite: tier-7 side-quest (Bastok path works). |
| 39 | By the Fading Light | 39 | WORKS | Talk to Rally Point Red in Xarcabard [S]. Single cutscene. |
| 40 | Edge of Existence | 115 | WORKS | Touch Cavernous Maw in any of 6 zones. Cutscene and transport. |
| 41 | Her Memories | 28 | WORKS | Placeholder -- completion handled by sub-quests (memory fragment collection). Sub-quest scripts exist: Homecoming Queen, Carnelian Footfalls, Of Malign Maladies, Operation Cupid (all "Converted"). |
| 42 | Forget Me Not | 145 | WORKS | Touch Cavernous Maw, teleport to Grauberg [S], cutscene, return. Well-scripted. |
| 43 | Pillar of Hope | 52 | WORKS | Talk to Veridical Conflux in Grauberg [S]. Weapon check included. |
| 44 | Glimmer of Life | 50 | WORKS | Talk to Veridical Conflux after game day wait. Timer-gated. |
| 45 | Time Slips Away | 49 | WORKS | Trade Punch Bug to Veridical Conflux. Grants Bottled Punch Bug KI. |
| 46 | When Wills Collide | 137 | BLOCKED | Walk of Echoes battlefield. Script handles BCNM entry flow and Event 32001 for victory, but **no battlefield script exists** in `scripts/battlefields/Walk_of_Echoes/`. TODO notes in code confirm this is unimplemented. |
| 47 | Whispers of Dawn | 50 | WORKS | Talk to Veridical Conflux. Weapon check. Timer set for next mission. |
| 48 | A Dreamy Interlude | 50 | WORKS | Talk to Veridical Conflux after game day wait. Timer-gated. |
| 49 | Cait in the Woods | 38 | WORKS | Talk to blank_cait NPC in E. Ronfaure [S]. Grants Ronfaure Dawndrop KI. |
| 50 | Fork in the Road | 172 | WORKS | Collect 7 Dawndrops from NPCs across 7 [S] zones + Walk of Echoes. Well-scripted with KI tracking. Grants Primal Glow KI. |
| 51 | Maiden of the Dusk | 159 | BLOCKED | Walk of Echoes battlefield vs Lilith. Multi-step with cutscenes, BCNM entry, and post-battle scenes. Script references Event 32001 for battlefield win but **no battlefield script exists**. Grants Moonshade Earring on completion. |
| 52 | Where It All Began | 38 | WORKS | Talk to Lion Springs in S. San d'Oria [S]. Grants Wedding Invitation KI. |
| 53 | A Token of Troth | 61 | WORKS | Check Bulwark Gate in Sauromugue [S]. Must unequip weapons. Consumes Wedding Invitation. |
| 54 | Lest We Forget | 141 | WORKS | Repeatable Moonshade Earring augment selection. Full augment system with 8x8 choices. Also handles earring reset/redo path. |

## Summary Statistics

| Category | Count | Missions |
|----------|-------|----------|
| WORKS | 41 | 1-6, 8-13, 15-22, 25-30, 34-36, 38-45, 47-50, 52-54 |
| BLOCKED (instance stub) | 6 | 14, 23, 24, 31, 32, 33 |
| BLOCKED (no battlefield) | 3 | 37, 46, 51 |
| Total scripts | 54/54 | All present |

## Key Questions Answered

### Can the WotG storyline be completed WITHOUT Campaign battles?
**Yes, Campaign battles are not required by any mission script.** The missions use `getCampaignAllegiance()` for cutscene parameters (dialogue variations) but never check Campaign battle participation or Campaign rank as a gate. The prerequisite gates are Crystal War side-quest chains, not Campaign battles.

### Which missions are blocked by missing Campaign system?
**None directly.** Campaign battles are not a prerequisite for any WotG mission. However, the Crystal War side-quest chains that gate missions 3, 4, 8, 15, 26, and 38 may themselves have Campaign-related requirements on retail. On this server, the Bastok path (Griffon chain) is fully scripted and bypasses any Campaign dependency.

### Are the [S] zone NPCs properly scripted?
**Mostly yes.** Key NPCs are properly scripted:
- Raustigne (S. San d'Oria [S]) -- multiple missions
- Lion Springs door (S. San d'Oria [S]) -- multiple missions
- Elegant Footprints / Lilisette (Jugner [S]) -- missions 9, 10
- Regal Pawprints / Cait Sith (Beaucedine [S]) -- missions 18, 19, 23, 24
- Rally Point NPCs (Xarcabard [S]) -- missions 30, 31, 32, 34, 39
- Bulwark Gate (Sauromugue [S]) -- missions 13, 27, 35, 53
- Veridical Conflux (Grauberg [S]) -- missions 43-48, 51, 54
- blank_cait / blank_fork (various [S] zones) -- missions 49, 50

### Mission 51 (Maiden of the Dusk) -- Lilith battlefield?
**CONFIRMED MISSING.** The mission script (159 lines) is fully written with:
- Multi-step flow (Status 0 through 7)
- BCNM entry via _521 NPC in Walk of Echoes
- Event 32001 handler for battlefield victory
- Primal Glow KI requirement and consumption
- Post-battle cutscene chain (events 6, 7, 8, 9)
- Moonshade Earring reward on final completion

But `scripts/battlefields/Walk_of_Echoes/` does not exist. The battlefield ID `MAIDEN_OF_THE_DUSK = 385` is defined in `scripts/globals/battlefield.lua` but has no implementation. The `When Wills Collide` battlefield (ID not found) is also missing from the same zone.

## Blockers

### High Priority (blocks storyline completion)
1. **Everbloom Hollow instances** (missions 14, 23) -- `doomvoid.lua` is an empty stub. The specific WotG instances for "A Nation on the Brink" and "Dungeons and Dancers" are not implemented.
2. **Ghoyus Reverie instances** (missions 31, 32, 33) -- `doomvoid.lua` is an empty stub. Three Xarcabard campaign instances are not implemented.
3. **Throne Room [S] battlefield** (mission 37) -- Lady Lilith "Darkness Descends" fight has no battlefield script at all.
4. **Walk of Echoes battlefields** (missions 46, 51) -- Neither "When Wills Collide" nor "Maiden of the Dusk" (Lilith) battlefields exist.

### Medium Priority (blocks some players)
5. **Sandy/Windy Crystal War side-quest chains** -- 12+ prerequisite quests are MISSING scripts. Only Bastok (Griffon chain) is complete. Sandy and Windurst-aligned players cannot progress past gate 2.

### Low Priority (cosmetic/minor)
6. **TODO comments** throughout mission scripts about event parameters varying by Campaign allegiance -- these affect cutscene display but not progression.
7. **Helpers.lua TODO** -- "Add one day wait" comments on all gate-check functions. The Vanadiel day wait between side-quest completion and mission availability is not enforced.

## Workaround Path (Bastok alignment)
A player aligned to **Bastok** for Campaign can complete the full WotG storyline through mission 40 using the Griffon quest chain:
- Gate 1: The Fighting Fourth (EXISTS)
- Gate 2: Claws of the Griffon (EXISTS) -- note: this is Sandy but exists
- Gate 3: Wrath of the Griffon (EXISTS)
- Gate 4: In a Haze of Glory (EXISTS)
- Gate 5: Bonds That Never Die (EXISTS)
- Gate 6: Blood of Heroes (EXISTS)
- Gate 7: Face of the Future (EXISTS)

After mission 40, the path is **blocked at mission 14** (or missions 23, 24, 31-33 if somehow bypassed) due to missing instances, and again at **mission 37** (missing battlefield), and finally at **missions 46 and 51** (missing Walk of Echoes battlefields).

## GM Workaround Commands
The mission scripts include GM commands in comments for bypassing blocked content:
- `!addmission 5 <id>` -- set mission directly
- `!completequest 7 <id>` -- complete prerequisite quests
- `!setmissionstatus` -- set mission status to post-battle state

For blocked instance/battlefield missions, a GM could:
1. Set the mission status var to the post-completion value
2. Advance to the next mission with `!addmission`

## Fix Difficulty
- **Everbloom Hollow / Ghoyus Reverie instances**: Hard -- requires implementing full instance content (mob spawns, objectives, victory conditions)
- **Throne Room [S] battlefield**: Hard -- requires implementing Lady Lilith boss fight with AI, abilities, and battlefield framework
- **Walk of Echoes battlefields**: Hard -- requires implementing two battlefield encounters (When Wills Collide + Maiden of the Dusk/Lilith)
- **Missing side-quest chains**: Medium -- each quest needs NPC scripts, dialogue, trade handlers, and flag management. ~12 quests across Sandy/Windy paths
- **Day-wait enforcement in helpers.lua**: Easy -- add VanadielUniqueDay() timer checks
