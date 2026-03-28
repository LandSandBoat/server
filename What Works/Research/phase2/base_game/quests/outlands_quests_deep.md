# Outlands Quests -- Deep Audit

Audited: 2026-03-28
Scripts path: `scripts/quests/outlands/`
Total scripts: 24

---

## CRITICAL BUG FOUND

**The_Missing_Piece.lua line 82-83** -- Uses `player.addKeyItem(player, ...)` (dot notation) instead of `player:addKeyItem(...)` (colon notation). This is a Lua method call bug. The dot form passes `player` as the first argument twice, which will either error or silently fail. The player will never receive `TABLET_OF_ANCIENT_MAGIC` or `LETTER_FROM_ALFESAR`, softlocking the quest at Prog 2.

```lua
-- BROKEN (line 82-83):
player.addKeyItem(player, xi.ki.TABLET_OF_ANCIENT_MAGIC)
player.addKeyItem(player, xi.ki.LETTER_FROM_ALFESAR)
-- SHOULD BE:
player:addKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)
player:addKeyItem(xi.ki.LETTER_FROM_ALFESAR)
```

---

## Quest-by-Quest Audit Table

| # | Quest | Area | Type | Status | Reward | Mods OK? | Issues |
|---|-------|------|------|--------|--------|----------|--------|
| 1 | Forge Your Destiny | Norg | SAM Unlock | GOOD | Mumeito (sword) + SAM job unlock | Yes (17812: STR+1, AGI+1) | TODO: Add Vanadiel day constant for 3-day wait |
| 2 | The Sacred Katana | Norg | SAM AF1 | GOOD | Magoroku (katana) | Yes (17812) | Clean. Requires Forge Your Destiny + SAM main + AF1 level |
| 3 | Yomi Okuri | Norg | SAM AF2 | GOOD | Myochin Sune-Ate (feet) | Yes (14100: DEF 13, HP 20, etc.) | Clean. Multi-zone NM chain works correctly |
| 4 | A Thief in Norg | Norg | SAM AF3 | GOOD | Myochin Kabuto (head) + Paragon title | Yes (13868: DEF 20, HP 10, MND+5, etc.) | Clean. Battlefield + multi-zone chain |
| 5 | A Question of Taste | Kazham | Story | GOOD | 3000 gil | N/A | Complex repeat logic with Temple of Uggalepih NM. Well implemented with post-complete repeat |
| 6 | Everyone's Grudging | Kazham | Story | GOOD | 11000 gil | N/A | Sequel to Question of Taste. Requires rancorCurse charVar + fame 7 |
| 7 | You Call That a Knife | Kazham | Story | GOOD | 7200 gil + title | N/A | Complex multi-zone. Chef Nonberry NM spawn with cooldown timer |
| 8 | Cloak and Dagger | Kazham | WS Unlock | GOOD | Evisceration (dagger WS) | N/A | Weapon skill quest. Clean implementation |
| 9 | Bugi Soden | Norg | WS Unlock | GOOD | Blade: Ku (katana WS) | N/A | Weapon skill quest. Clean implementation |
| 10 | The Potential Within | Norg | WS Unlock | GOOD | Tachi: Kasha (great katana WS) | N/A | Weapon skill quest. Clean implementation |
| 11 | Like Shining Subligar | Norg | Collect | GOOD | Scroll of Kurayami: Ichi | N/A | Trade 10 Rusty Subligars. Clean |
| 12 | Like Shining Leggings | Norg | Collect | GOOD | Scroll of Dokumori: Ichi | N/A | Trade 10 Rusty Leggings. Clean |
| 13 | Secret of the Damp Scroll | Norg | Story | GOOD | Scroll of Jubaku: Ichi + title | N/A | Simple trade quest to Horlais Peak. Clean |
| 14 | The Sahagin's Stash | Norg | Story | GOOD | Scroll of Utsusemi: Ichi + title | N/A | Sea Serpent Grotto KI fetch. Clean |
| 15 | Stop Your Whining | Norg | Story | GOOD | Scroll of Hojo: Ichi + title | N/A | Yhoator Jungle KI exchange. Clean |
| 16 | Divine Might | Misc | BF | GOOD | Earring choice (5 options) + title | Yes (all 5 earrings have mods) | TODO: forever charVar for DM_Earring |
| 17 | Divine Might (Repeat) | Misc | BF | GOOD | Same earring choice + title | Yes | TODO: forever charVar for DM_Earring. Adds Moonlight Ore path |
| 18 | Open Sesame | E. Altepa | Story | GOOD | Loadstone (KI) | N/A | Trade options with Tremorstone + gem/geode/meteorite. Clean |
| 19 | The Missing Piece | Rabao | Story | **BUG** | Scroll of Teleport-Altep | N/A | **CRITICAL: player.addKeyItem bug on lines 82-83 -- quest softlocks at Prog 2** |
| 20 | The Kuftal Tour | Rabao | Story | GOOD | 8000 gil + title | N/A | Level cap 40 party requirement in Kuftal Tunnel. Clean |
| 21 | Chasing Dreams | Rabao | CoP | GOOD | Venerer Ring + 4000 gil | Yes (14655: ACC+3) | TODO: Unknown pre-req (possibly CoP 2-1). Currently no pre-req check |
| 22 | Wandering Souls | Cape Teriggan | Headstone | GOOD | Flagellant's Rope + title | Yes (13248: DEF 4, AGI+1, Wind MEVA+3) | No QUEST_AVAILABLE section -- only triggered via parent quest system |
| 23 | Soul Searching | Zi'Tah | Headstone | GOOD | Bat Earring + title | Yes (13416: MP+5, Dark MEVA+3) | No QUEST_AVAILABLE section -- only triggered via parent quest system |
| 24 | Wrath of the Opo-Opos | Yuhtunga | Headstone | GOOD | Opo-opo Necklace + title | Yes (13143: DEX+1, Thunder MEVA+3) | No QUEST_AVAILABLE section -- only triggered via parent quest system |

---

## TODOs in Code

| File | Line | TODO |
|------|------|------|
| Chasing_Dreams.lua | 63 | Pre-req unknown. Wiki says CoP 2-1. Currently accepts with no pre-req check |
| Forge_Your_Destiny.lua | 187 | Add constant for Vanadiel day in seconds (currently hardcoded 10368) |
| Divine_Might.lua | 107 | Find way to avoid forever charVar for DM_Earring |
| Divine_Might_Repeat.lua | 105 | Same forever charVar issue |

---

## Equipment Reward Mod Verification

All equipment rewards have mods in `sql/item_mods.sql`:

| Item | ID | Mods |
|------|----|------|
| Magoroku (SAM AF1 katana) | 17812 | STR+1, AGI+1 |
| Myochin Sune-Ate (SAM AF2 feet) | 14100 | DEF 13, HP+20, Fire MEVA+10, Enmity+5, Evasion+5 |
| Myochin Kabuto (SAM AF3 head) | 13868 | DEF 20, HP+10, MND+5, Meditate Duration+4, Warding Circle +90s/+2 potency |
| Suppanomimi (DM earring) | 14739 | AGI+2, Sword+5, Dual Wield+5 |
| Knight's Earring (DM earring) | 14740 | VIT+2, Shield+5, Divine+5 |
| Abyssal Earring (DM earring) | 14741 | INT+2, Scythe+5, Dark+5 |
| Beastly Earring (DM earring) | 14742 | CHR+2, EVA+5, Axe+5 |
| Bushinomimi (DM earring) | 14743 | STR+2, GKatana+5, Parry+5 |
| Venerer Ring (Chasing Dreams) | 14655 | ACC+3 |
| Bat Earring (Soul Searching) | 13416 | MP+5, Dark MEVA+3 |
| Flagellant's Rope (Wandering Souls) | 13248 | DEF 4, AGI+1, Wind MEVA+3 |
| Opo-opo Necklace (Wrath of Opo-Opos) | 13143 | DEX+1, Thunder MEVA+3 |

---

## SAM Unlock Chain Audit

Full chain verified and working:
1. **Forge Your Destiny** (QID 129) -- Level requirement from settings. Trade Bomb Steel + Sacred Branch to Jaucribaix. NM fights (Guardian Treant in Zi'Tah, Forger in Konschtat). 3 Vanadiel-day wait. Unlocks SAM job.
2. **The Sacred Katana** (QID 140) -- Requires Forge Your Destiny complete + SAM main + AF1 level. NM fight (Isonade in Zi'Tah). Trade Mumeito + Crystal Scales.
3. **Yomi Okuri** (QID 141) -- Requires Sacred Katana + SAM main + AF2 level. Multi-step: Washu trade, Ubume NM in Onzozo, Doman/Onryo NMs in Valkurm (nighttime only).
4. **A Thief in Norg** (QID 142) -- Requires Yomi Okuri + SAM main + AF3 level. Multi-zone (Norg/Port Jeuno/Mhaura/Bastok Mines/Waughroon Shrine battlefield). Final SAM AF piece.

All mustZone flags properly set between quests. Chain progression logic is correct.

---

## NIN Unlock Chain

The NIN unlock quest **Ayame and Kaede** is in `scripts/quests/bastok/` (Bastok quest log), NOT in Outlands. This is correct -- it starts in Bastok despite involving Norg. No NIN-specific unlock quest exists in the Outlands quest log.

---

## Missing Quests -- Defined in quests.lua But No Script

### Not implemented at all (no `+` marker):

| Quest | QID | Notes |
|-------|-----|-------|
| A Discerning Eye | 14 | Kazham quest |
| Black Market | 130 | Norg quest |
| Mama Mia | 131 | Norg quest |
| An Undying Pledge | 149 | Norg quest |
| The Search for Goldmane | 200 | Rabao CoP quest |

### Implemented in old format (have `+` but not converted to quest framework):

| Quest | QID | Area | Notes |
|-------|-----|------|-------|
| The Firebloom Tree | 1 | Kazham | |
| Greetings to the Guardian | 2 | Kazham | |
| Missionary Man | 7 | Kazham | |
| Gullible's Travels | 8 | Kazham | |
| Even More Gullible's Travels | 9 | Kazham | |
| Personal Hygiene | 10 | Kazham | |
| The Opo-opo and I | 11 | Kazham | |
| Trial by Fire | 12 | Kazham | Avatar prime fight |
| Trial Size Trial by Fire | 15 | Kazham | Mini avatar fight |
| The Sahagin's Key | 128 | Norg | |
| Trial by Water | 133 | Norg | Avatar prime fight |
| Everyone's Grudge | 134 | Norg | Different from Everyone's Grudging |
| It's Not Your Vault | 137 | Norg | |
| Twenty in Pirate Years | 143 | Norg | |
| I'll Take the Big Box | 144 | Norg | |
| True Will | 145 | Norg | |
| Trial Size Trial by Water | 148 | Norg | Mini avatar fight |
| Don't Forget the Antidote | 192 | Rabao | |
| Trial by Wind | 194 | Rabao | Avatar prime fight |
| Trial Size Trial by Wind | 197 | Rabao | Mini avatar fight |
| The Immortal Lu Shang | 196 | Rabao | Lu Shang's fishing rod quest |
| Indomitable Spirit | 201 | Rabao | |

### Known BG-Wiki quests likely missing entirely:

| Quest | Notes |
|-------|-------|
| Ayame and Kaede | In Bastok log, not Outlands -- correctly placed |
| Various Voidwatch ops | Voidwatch system separate, IDs 100-104 defined |

---

## Summary

- **24 scripts audited** in `scripts/quests/outlands/`
- **1 critical bug**: The_Missing_Piece.lua -- `player.addKeyItem` dot-notation bug softlocks quest
- **4 TODOs** found across scripts (pre-req validation, constants, charVar cleanup)
- **5 quests** completely unimplemented (no script, no `+` marker)
- **22 quests** implemented in old format but not converted to new quest framework
- **0 equipment mod issues** -- all item rewards verified in item_mods.sql
- **SAM unlock chain** fully verified and working (4 quests)
- **NIN unlock** correctly located in Bastok, not Outlands
- **Headstone quests** (Wandering Souls, Soul Searching, Wrath of Opo-Opos) have no QUEST_AVAILABLE section -- they are activated by a parent quest system (likely the main headstone/promyvion chain)
- **Chasing Dreams** has no pre-req check despite TODO noting one is needed (possibly CoP 2-1)
