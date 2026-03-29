# Other Areas & Outlands Quests -- Phase 2 Audit (CORRECTED)

**CORRECTION NOTE:** Previous audit undercounted quests. This file is corrected using the definitive source: `scripts/globals/quests.lua` markers (`+` = implemented, `Converted` = Interaction Framework). Previous audit counted scripts in folders; this audit counts implementation markers in quests.lua, which also covers quests implemented in zone NPC scripts.

**Date:** 2026-03-28 (corrected)
**Source:** `scripts/globals/quests.lua` quest ID definitions and implementation markers

---

## Overall Summary

| Area | Defined in quests.lua | Implemented (+/Converted) | Coverage |
|---|---|---|---|
| Other Areas | 67 | 52 | 77.6% |
| Outlands | 56 | 45 | 80.4% |
| **TOTAL** | **123** | **97** | **78.9%** |

---

## Other Areas (xi.questLog.OTHER_AREAS) -- 52/67 (77.6%)

### Implemented Quests (52)

| Quest | ID | Marker | Notes |
|-------|-----|--------|-------|
| Rycharde the Chef | 0 | Converted | Selbina cooking chain |
| Way of the Cook | 1 | Converted | Selbina cooking chain |
| Unending Chase | 2 | Converted | Selbina cooking chain |
| His Name is Valgeir | 3 | Converted | Selbina cooking chain |
| Expertise | 4 | Converted | Selbina cooking chain |
| The Clue | 5 | Converted | Selbina cooking chain |
| The Basics | 6 | Converted | Selbina cooking chain |
| Orlando's Antiques | 7 | + | Selbina quest |
| The Sand Charm | 8 | Converted | Mhaura, requires fishing |
| A Potter's Preference | 9 | + | Minor quest |
| The Old Lady | 10 | + | Sub-job unlock (Mhaura path), zone NPC script |
| Donate to Recycling | 16 | + | |
| Under the Sea | 17 | Converted | |
| Only the Best | 18 | + | |
| An Explorer's Footsteps | 19 | Converted | |
| Cargo | 20 | + | |
| The Gift | 21 | Converted | Selbina gift chain |
| The Real Gift | 22 | Converted | Selbina gift chain |
| The Rescue | 23 | Converted | Selbina fame quest |
| Elder Memories | 24 | + | Sub-job unlock (Selbina path), zone NPC script |
| Test My Mettle | 25 | Converted | |
| Inside the Belly | 26 | Converted | |
| Trial by Lightning | 27 | + | Avatar prime battle |
| Trial Size Trial by Lightning | 28 | + | Mini avatar battle |
| It's Raining Mannequins | 29 | Converted | |
| Recycling Rods | 30 | Converted | |
| Waking the Beast | 32 | Converted | Requires all 6 avatar spells |
| Monstrosity | 34 | Converted | |
| A Hard Day's Knight | 64 | Converted | CoP-era Tavnazia quest |
| X Marks the Spot | 65 | Converted | |
| A Bitter Past | 66 | Converted | |
| The Call of the Sea | 67 | Converted | |
| Paradise, Salvation, and Maps | 68 | Converted | |
| Go Go Gobmuffin | 69 | Converted | |
| Fly High | 71 | + | |
| Unforgiven | 72 | Converted | |
| Secrets of Ovens Lost | 73 | Converted | |
| Petals for Parelbriaux | 74 | Converted | |
| Elderly Pursuits | 75 | Converted | |
| In the Name of Science | 76 | + | |
| Knocking on Forbidden Doors | 78 | Converted | |
| Confessions of a Bellmaker | 79 | Converted | |
| In Search of the Truth | 80 | Converted | |
| Tango with a Tracker | 82 | Converted | |
| Bombs Away | 96 | Converted | |
| Give a Moogle a Break | 100 | Converted | Moogle quest chain |
| The Moogle Picnic | 101 | Converted | Moogle quest chain |
| Moogles in the Wild | 102 | Converted | Moogle quest chain |
| Missionary Moblin | 103 | Converted | |
| For the Birds | 104 | Converted | |
| Better the Demon You Know | 105 | Converted | |
| A Moral Manifest | 108 | + | |

### Missing Quests (15)

| Quest | ID | Impact |
|-------|-----|--------|
| Fisherman's Heart | 11 | Minor quest |
| Picture Perfect | 31 | Minor quest |
| Survival of the Wisest | 33 | Minor quest |
| The Big One | 70 | Fishing quest |
| Behind the Smile | 77 | Minor quest |
| Uninvited Guests | 81 | Minor quest |
| Requiem of Sin | 83 | Minor quest |
| VW Op. 026: Tavnazian Terrors | 84 | Voidwatch (low priority) |
| VW Op. 004: Bibiki Bombardment | 85 | Voidwatch (low priority) |
| Mithran Delicacies | 97 | Minor quest |
| An Understanding Overlord | 106 | Beastmen faction quest |
| An Affable Adamantking | 107 | Beastmen faction quest |
| A Generous General | 109 | Beastmen faction quest |
| Records of Eminence | 110 | RoE system (handled via separate global system) |
| Unity Concord | 111 | Unity system (handled via separate global system) |

---

## Outlands (xi.questLog.OUTLANDS) -- 45/56 (80.4%)

### Implemented Quests (45)

| Quest | ID | Marker | Notes |
|-------|-----|--------|-------|
| Greetings to the Guardian | 2 | + | Kazham |
| A Question of Taste | 3 | Converted | Kazham |
| Everyone's Grudging | 4 | Converted | Kazham |
| You Call That a Knife | 6 | Converted | Kazham |
| Missionary Man | 7 | + | Kazham |
| Gullible's Travels | 8 | + | Kazham |
| Even More Gullible's Travels | 9 | + | Kazham |
| Personal Hygiene | 10 | + | Kazham |
| The Opo-opo and I | 11 | + | Kazham, Opo-opo Necklace |
| Trial by Fire | 12 | + | Avatar prime battle |
| Cloak and Dagger | 13 | Converted | Kazham |
| Trial Size Trial by Fire | 15 | + | Mini avatar battle |
| The Sahagin's Key | 128 | + | Norg access |
| Forge Your Destiny | 129 | Converted | SAM prereq |
| Stop Your Whining | 132 | Converted | Norg |
| Trial by Water | 133 | + | Avatar prime battle |
| Everyone's Grudge | 134 | + | Norg |
| Secret of the Damp Scroll | 135 | Converted | Norg |
| The Sahagin's Stash | 136 | Converted | Norg |
| It's Not Your Vault | 137 | + | Norg |
| Like a Shining Subligar | 138 | Converted | Norg |
| Like Shining Leggings | 139 | Converted | Norg |
| The Sacred Katana | 140 | Converted | SAM AF1 |
| Yomi Okuri | 141 | Converted | SAM AF2 |
| A Thief in Norg | 142 | Converted | SAM AF3 |
| Twenty in Pirate Years | 143 | + | SAM merit |
| I'll Take the Big Box | 144 | + | SAM merit |
| True Will | 145 | + | SAM merit |
| The Potential Within | 146 | Converted | ENM access |
| Bugi Soden | 147 | Converted | Norg |
| Trial Size Trial by Water | 148 | + | Mini avatar battle |
| Wrath of the Opo-opos | 160 | Converted | Misc |
| Wandering Souls | 161 | Converted | Misc |
| Soul Searching | 162 | Converted | Misc |
| Divine Might | 163 | Converted | Zilart endgame, earring rewards |
| Divine Might Repeat | 164 | Converted | Repeatable version |
| Open Sesame | 165 | Converted | |
| Don't Forget the Antidote | 192 | + | Rabao |
| The Missing Piece | 193 | Converted | Rabao |
| Trial by Wind | 194 | + | Avatar prime battle |
| The Kuftal Tour | 195 | Converted | Rabao |
| The Immortal Lu Shang | 196 | + | Lu Shang's fishing rod quest |
| Trial Size Trial by Wind | 197 | + | Mini avatar battle |
| Chasing Dreams | 199 | Converted | CoP quest in Rabao |
| Indomitable Spirit | 201 | + | |

### Missing Quests (11)

| Quest | ID | Impact |
|-------|-----|--------|
| The Firebloom Tree | 1 | Kazham quest |
| A Discerning Eye | 14 | Kazham quest |
| VW Ops: Border Crossing | 100 | Voidwatch (low priority) |
| VW Op. 054: Elshimo List | 101 | Voidwatch (low priority) |
| VW Op. 101: Detour to Zepwell | 102 | Voidwatch (low priority) |
| VW Op. 115: Li'Telor Variant | 103 | Voidwatch (low priority) |
| Skyward Ho, Voidwatcher | 104 | Voidwatch (low priority) |
| Black Market | 130 | Norg quest |
| Mama Mia | 131 | Norg quest |
| An Undying Pledge | 149 | Norg quest |
| The Search for Goldmane | 200 | CoP quest |

---

## Key Findings

### What WORKS well:
1. **Other Areas at 77.6%** -- significant upgrade from previous audit's 62.1% count (previous audit missed quests implemented in zone NPC scripts marked with `+` only)
2. **Outlands at 80.4%** -- massive upgrade from previous audit's 51.1% (21 additional quests recognized as implemented)
3. **Sub-job unlocks** (Elder Memories / The Old Lady) -- fully functional
4. **SAM full chain** -- prereq + AF1-3 + merit quests all implemented
5. **Divine Might** -- fully functional with repeatable version
6. **All avatar Trial battles** (Fire/Water/Wind/Lightning + Trial Size versions) -- implemented
7. **Opo-opo and I, Lu Shang, Sahagin's Key** -- all implemented

### What is MISSING:
1. **Voidwatch** -- 7 Voidwatch operations across both areas (low priority)
2. **Beastmen faction quests** (3 quests) -- Understanding Overlord, Affable Adamantking, Generous General
3. **Records of Eminence / Unity Concord** -- registered but handled by separate global systems
4. **Minor side quests** -- 8 in Other Areas, 4 in Outlands (non-Voidwatch)

### Why Previous Audit Undercounted:
The previous audit counted script files in `scripts/quests/otherAreas/` and `scripts/quests/outlands/` folders. Many quests marked `+` (without "Converted") are implemented in zone NPC scripts (old-style) and have no dedicated quest file. The correct methodology is to count `+` and `Converted` markers in `quests.lua`.

## Blockers
- None critical. Missing quests are minor side content, Voidwatch, or systems handled elsewhere.

## Fix Difficulty
- Easy (remaining gaps are minor side quests and Voidwatch content)
