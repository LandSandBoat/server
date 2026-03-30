# WotG-Era Gear Deep Verification

## Source
- bg-wiki: Individual item pages (linked per section)
- Codebase: `sql/item_basic.sql`, `sql/item_mods.sql`, `scripts/missions/wotg/54_Lest_We_Forget.lua`

## Summary
20 items spot-checked. All DNC AF (5 pieces), SCH AF (5 pieces), and Cobra Campaign gear (9 pieces) mod values match bg-wiki exactly. Moonshade Earring augment script is fully implemented with correct augment values. No discrepancies found.

---

## DNC Artifact Armor (5 pieces)

### Dancer's Tiara (ID: 16138)
bg-wiki: https://www.bg-wiki.com/ffxi/Dancer%27s_Tiara

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 18 | 18 | YES |
| HP (2) | 10 | 10 | YES |
| CHR (14) | 4 | 4 | YES |
| Enmity (27) | -2 | -2 | YES |
| Samba Duration (490) | 30 | 30 sec | YES |

Status: **WORKS** -- All mods match retail.

### Dancer's Casaque (ID: 14578)
bg-wiki: https://www.bg-wiki.com/ffxi/Dancer%27s_Casaque

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 38 | 38 | YES |
| HP (2) | 20 | 20 | YES |
| STR (8) | 2 | 2 | YES |
| DEX (9) | 2 | 2 | YES |
| Enmity (27) | -2 | -2 | YES |
| Waltz Potency (491) | 10 | 10% | YES |

Note: Also has RSE mod (276)=149 for race-specific equipment flag. This is a server implementation detail, not a retail stat.

Status: **WORKS** -- All mods match retail.

### Dancer's Bangles (ID: 15002)
bg-wiki: https://www.bg-wiki.com/ffxi/Dancer%27s_Bangles

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 15 | 15 | YES |
| HP (2) | 12 | 12 | YES |
| DEX (9) | 2 | 2 | YES |
| AGI (11) | 2 | 2 | YES |
| Step Accuracy (403) | 10 | 10 | YES |

Status: **WORKS** -- All mods match retail.

### Dancer's Tights (ID: 15659)
bg-wiki: https://www.bg-wiki.com/ffxi/Dancer%27s_Tights

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 28 | 28 | YES |
| HP (2) | 10 | 10 | YES |
| CHR (14) | 3 | 3 | YES |
| ACC (25) | 3 | 3 | YES |
| Enmity (27) | -1 | -1 | YES |

Status: **WORKS** -- All mods match retail.

### Dancer's Toe Shoes (ID: 15746)
bg-wiki: https://www.bg-wiki.com/ffxi/Dancer%27s_Toe_Shoes

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 14 | 14 | YES |
| HP (2) | 7 | 7 | YES |
| ATT (23) | 5 | 5 | YES |
| EVA (68) | 5 | 5 | YES |
| Jig Duration (492) | 25 | 25% | YES |

Status: **WORKS** -- All mods match retail.

---

## SCH Artifact Armor (5 pieces)

### Scholar's Mortarboard (ID: 16140)
bg-wiki: https://www.bg-wiki.com/ffxi/Scholar%27s_Mortarboard

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 15 | 15 | YES |
| MP (5) | 15 | 15 | YES |
| INT (12) | 4 | 4 | YES |
| Sublimation Bonus (401) | 1 | +1/tic | YES |

Status: **WORKS** -- All mods match retail.

### Scholar's Gown (ID: 14580)
bg-wiki: https://www.bg-wiki.com/ffxi/Scholar%27s_Gown

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 38 | 38 | YES |
| MP (5) | 13 | 13 | YES |
| INT (12) | 1 | 1 | YES |
| MND (13) | 1 | 1 | YES |
| Dark Arts Skill (337) | 15 | +15 skill | YES |

Note: bg-wiki says Dark Arts adds +15 to elemental/enfeebling/dark magic skills. Server implements mod 337 (DARK_ARTS_SKILL) = 15 which is the correct implementation.

Status: **WORKS** -- All mods match retail.

### Scholar's Bracers (ID: 15004)
bg-wiki: https://www.bg-wiki.com/ffxi/Scholar%27s_Bracers

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 13 | 13 | YES |
| MP (5) | 15 | 15 | YES |
| MND (13) | 3 | 3 | YES |
| Enmity (27) | -2 | -2 | YES |
| Spell Interruption Down (168) | 20 | 20% | YES |

Status: **WORKS** -- All mods match retail.

### Scholar's Pants (ID: 16311)
bg-wiki: https://www.bg-wiki.com/ffxi/Scholar%27s_Pants

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 27 | 27 | YES |
| MP (5) | 20 | 20 | YES |
| Enmity (27) | -1 | -1 | YES |
| Light Arts Skill (336) | 15 | +15 skill | YES |

Note: bg-wiki says Light Arts adds +15 healing/enhancing/divine/enfeebling magic skill. Server uses mod 336 (LIGHT_ARTS_SKILL) = 15.

Status: **WORKS** -- All mods match retail.

### Scholar's Loafers (ID: 15748)
bg-wiki: https://www.bg-wiki.com/ffxi/Scholar%27s_Loafers

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 10 | 10 | YES |
| MP (5) | 15 | 15 | YES |
| Enmity (27) | -2 | -2 | YES |
| Grimoire Spellcasting (489) | -5 | -5% cast time | YES |

Status: **WORKS** -- All mods match retail.

---

## Moonshade Earring (ID: 11697)

bg-wiki: https://www.bg-wiki.com/ffxi/Moonshade_Earring

**Base Stats:** No base mods in item_mods.sql (correct -- this is an augment-only item).

**Augment Script:** `scripts/missions/wotg/54_Lest_We_Forget.lua`

The augment system is implemented directly in the WotG mission 54 script. The earring is granted via `player:addItem()` with augment parameters.

### Augment Set 1 (choose one):

| Augment | Server (ID, Value) | bg-wiki | Match? |
|---------|-------------------|---------|--------|
| ACC+4 | (23, 3) | Accuracy+4 | YES |
| ATK+4 | (25, 3) | Attack+4 | YES |
| RACC+4 | (27, 3) | Ranged Accuracy+4 | YES |
| RATK+4 | (29, 3) | Ranged Attack+4 | YES |
| MACC+4 | (35, 3) | Magic Accuracy+4 | YES |
| MAB+4 | (133, 3) | Magic Atk. Bonus+4 | YES |
| HP+25 | (1, 24) | HP+25 | YES |
| MP+25 | (9, 24) | MP+25 | YES |

### Augment Set 2 (choose one):

| Augment | Server (ID, Value) | bg-wiki | Match? |
|---------|-------------------|---------|--------|
| Regain +10 | (59, 0) | Latent Regain +10 TP/tic | YES |
| Refresh +1 | (60, 0) | Latent Refresh +1 MP/tic | YES |
| Occ. dmg bonus +5% | (352, 4) | Occ. dmg bonus based on TP +5% | YES |
| TP Bonus +250 | (353, 4) | TP Bonus +250 | YES |
| Occ. max MACC +3% | (350, 2) | Occ. maximizes magic accuracy +3% | YES |
| Occ. quicken spell +3% | (351, 2) | Occ. quickens spellcasting +3% | YES |
| Counter+3 | (145, 2) | Counter+3 | YES |
| Occ. status resist +5 | (61, 4) | Occ. resist status ailments +5% | YES |

**Re-augment support:** Script at line 59-69 handles `qm_reset` NPC to allow re-selection of augments if the player no longer has the earring.

Status: **WORKS** -- Augment script fully implemented with all 16 augment options matching bg-wiki.

---

## Campaign Reward Gear -- Cobra Unit Sets

### Cobra Coat Set (WHM/BRD-type, 5 pieces)

#### Cobra Unit Coat (ID: 14583)
bg-wiki: https://www.bg-wiki.com/ffxi/Cobra_Unit_Coat

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 32 | 32 | YES |
| INT (12) | 2 | 2 | YES |
| MND (13) | 2 | 2 | YES |
| CHR (14) | 2 | 2 | YES |
| Light MEVA (21) | 4 | Light+4 | YES |
| Dark MEVA (22) | 4 | Dark+4 | YES |

Status: **WORKS**

#### Cobra Unit Hat (ID: 16143)
bg-wiki: https://www.bg-wiki.com/ffxi/Cobra_Unit_Hat

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 17 | 17 | YES |
| INT (12) | 2 | 2 | YES |
| MP Heal (71) | 1 | +1 | YES |

Status: **WORKS**

#### Cobra Unit Cuffs (ID: 15007)
bg-wiki: https://www.bg-wiki.com/ffxi/Cobra_Unit_Cuffs

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 11 | 11 | YES |
| INT (12) | 1 | 1 | YES |
| MND (13) | 1 | 1 | YES |
| CHR (14) | 1 | 1 | YES |
| EVA (68) | 5 | 5 | YES |

Status: **WORKS**

#### Cobra Unit Slops (ID: 16314)
bg-wiki: https://www.bg-wiki.com/ffxi/Cobra_Unit_Slops

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 23 | 23 | YES |
| INT (12) | 1 | 1 | YES |
| CHR (14) | 1 | 1 | YES |
| Dark MEVA (22) | 7 | Dark+7 | YES |

Status: **WORKS**

#### Cobra Unit Pigaches (ID: 15751)
bg-wiki: https://www.bg-wiki.com/ffxi/Cobra_Unit_Pigaches

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 10 | 10 | YES |
| MND (13) | 2 | 2 | YES |
| CHR (14) | 2 | 2 | YES |
| Ice MEVA (16) | 11 | Ice+11 | YES |

Status: **WORKS**

### Cobra Harness Set (Melee DPS, spot-checked 2 pieces)

#### Cobra Unit Harness (ID: 14590)
bg-wiki: https://www.bg-wiki.com/ffxi/Cobra_Unit_Harness

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 42 | 42 | YES |
| ACC (25) | 11 | 11 | YES |
| Enmity (27) | -8 | -8 | YES |
| Store TP (73) | 6 | 6 | YES |

Status: **WORKS**

#### Cobra Unit Cap (ID: 16148)
bg-wiki: https://www.bg-wiki.com/ffxi/Cobra_Unit_Cap

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 22 | 22 | YES |
| ACC (25) | 4 | 4 | YES |
| Enmity (27) | -4 | -4 | YES |
| Store TP (73) | 2 | 2 | YES |

Status: **WORKS**

### Cobra Robe Set (Mage DPS, spot-checked 2 pieces)

#### Cobra Unit Robe (ID: 14591)
bg-wiki: https://www.bg-wiki.com/ffxi/Cobra_Unit_Robe

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 39 | 39 | YES |
| HP (2) | 32 | 32 | YES |
| MP (5) | 32 | 32 | YES |
| MAB (28) | 4 | 4 | YES |
| Conserve MP (296) | 3 | 3 | YES |

Status: **WORKS**

#### Cobra Unit Cloche (ID: 16149)
bg-wiki: https://www.bg-wiki.com/ffxi/Cobra_Unit_Cloche

| Mod | Server Value | bg-wiki Value | Match? |
|-----|-------------|---------------|--------|
| DEF (1) | 12 | 12 | YES |
| HP (2) | 15 | 15 | YES |
| MP (5) | 15 | 15 | YES |
| MAB (28) | 1 | 1 | YES |
| Conserve MP (296) | 2 | 2 | YES |

Status: **WORKS**

---

## Checklist Summary

| Item | ID | Status | Notes |
|------|-----|--------|-------|
| Dancer's Tiara | 16138 | WORKS | All 5 mods match bg-wiki |
| Dancer's Casaque | 14578 | WORKS | All 6 mods match bg-wiki |
| Dancer's Bangles | 15002 | WORKS | All 5 mods match bg-wiki |
| Dancer's Tights | 15659 | WORKS | All 5 mods match bg-wiki |
| Dancer's Toe Shoes | 15746 | WORKS | All 5 mods match bg-wiki |
| Scholar's Mortarboard | 16140 | WORKS | All 4 mods match bg-wiki |
| Scholar's Gown | 14580 | WORKS | All 5 mods match bg-wiki |
| Scholar's Bracers | 15004 | WORKS | All 5 mods match bg-wiki |
| Scholar's Pants | 16311 | WORKS | All 4 mods match bg-wiki |
| Scholar's Loafers | 15748 | WORKS | All 4 mods match bg-wiki |
| Moonshade Earring | 11697 | WORKS | All 16 augment options match bg-wiki |
| Cobra Unit Coat | 14583 | WORKS | All 6 mods match bg-wiki |
| Cobra Unit Hat | 16143 | WORKS | All 3 mods match bg-wiki |
| Cobra Unit Cuffs | 15007 | WORKS | All 5 mods match bg-wiki |
| Cobra Unit Slops | 16314 | WORKS | All 4 mods match bg-wiki |
| Cobra Unit Pigaches | 15751 | WORKS | All 4 mods match bg-wiki |
| Cobra Unit Harness | 14590 | WORKS | All 4 mods match bg-wiki |
| Cobra Unit Cap | 16148 | WORKS | All 4 mods match bg-wiki |
| Cobra Unit Robe | 14591 | WORKS | All 5 mods match bg-wiki |
| Cobra Unit Cloche | 16149 | WORKS | All 5 mods match bg-wiki |

**Total: 20 items verified, 0 discrepancies found.**

## Blockers
- None. All checked WotG-era gear mods are accurate.

## Fix Difficulty
- N/A -- No fixes needed.
