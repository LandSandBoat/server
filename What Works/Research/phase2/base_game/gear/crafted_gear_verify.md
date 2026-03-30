# Crafted Gear Deep Verification

## Source
- bg-wiki: individual item pages (URLs below per item)
- Codebase: `sql/item_mods.sql`, `sql/item_basic.sql`, `sql/item_latents.sql`, `sql/synth_recipes.sql`, `scripts/items/vile_elixir*.lua`

## Summary
Most commonly crafted equipment has correct mods. Platinum Ring +1 has an MP penalty discrepancy (-7 server vs -7 bg-wiki -- MATCHES after recheck). All Blessed WHM gear, rings, and armor pieces verified correct. Vile Elixirs are NOT crafted items (drop/purchase only) but their scripts correctly implement 25%/55% HP+MP restore. Two notable findings: Darksteel Harness correctly implements "Physical damage taken" as both DMGPHYS and DMGRANGE, and the I.M. Cuirass latent EVA bonuses are properly implemented.

## Checklist

### Smithing

| Item | ID | Status | Notes |
|------|-----|--------|-------|
| Iron Musketeer's Cuirass | 12550 | WORKS | DEF:40 VIT+1 -- matches bg-wiki exactly |
| Iron Musketeer's Cuirass +1 | 14342 | WORKS | DEF:41 VIT+1, Latent EVA+6 (nation control) -- matches bg-wiki exactly |
| Iron Musketeer's Cuirass +2 | 14343 | WORKS | DEF:42 VIT+1, Latent EVA+7 (nation control) -- matches bg-wiki exactly |
| Darksteel Harness | 12580 | WORKS | DEF:39 Light+2 Dark+2 DMGPHYS:-300 DMGRANGE:-300 -- bg-wiki: DEF:39 Light+2 Dark+2 Phys dmg taken -3%. DMGPHYS+DMGRANGE is standard LSB implementation of "Physical damage taken" |
| Darksteel Harness +1 | 13765 | WORKS | DEF:40 Light+3 Dark+3 DMGPHYS:-400 DMGRANGE:-400 -- bg-wiki: DEF:40 Light+3 Dark+3 Phys dmg taken -4%. Correct |
| Hauberk | 12556 | WORKS | DEF:47 STR+5 DEX+5 ATT+10 ACC+10 EVA-10 -- matches bg-wiki exactly |
| Hauberk +1 | 13793 | WORKS | DEF:48 STR+6 DEX+6 ATT+12 ACC+12 EVA-10 -- matches bg-wiki exactly |

#### Hauberk Cursed->Blessed Chain (Abjuration Path)

| Step | Status | Notes |
|------|--------|-------|
| Craft Cursed Hauberk (Smith 96) | WORKS | Recipe 14562 exists: Hauberk + ingots -> Cursed Hauberk (1356) / Cursed Hauberk -1 (1357) |
| Abjuration: Cursed Hauberk -> Adaman Hauberk | WORKS | `abjurations.lua` line 66: Earthen Abjuration: Body + Cursed Hauberk = Adaman Hauberk (NQ) / Armada Hauberk (HQ) |
| Adaman Hauberk mods | WORKS | ID 12557: DEF:53 STR+10 DEX+10 ATT+15 ACC+15 EVA-10 -- matches bg-wiki exactly |

#### ROV-era Bewitched Hauberk Chain

| Step | Status | Notes |
|------|--------|-------|
| Craft Bewitched Hauberk (Smith 95/115) | WORKS | Recipes 14552/15511 exist |
| Abjuration: Bewitched -> Argosy Hauberk | WORKS | `abjurations.lua` line 698: Vale Abjuration: Body + Bewitched Hauberk = Argosy Hauberk (NQ) / +1 (HQ) |
| Argosy Hauberk mods | WORKS | ID 26848: DEF:145 HP+68 STR+34 DEX+34 ATT+30 ACC+30 EVA-15 DA+4% Haste+3% |
| Argosy Hauberk +1 mods | WORKS | ID 26849: DEF:146 HP+68 STR+34 DEX+34 ATT+40 ACC+40 EVA-16 DA+4% Haste+3% |

### Goldsmithing

| Item | ID | Status | Notes |
|------|-----|--------|-------|
| Gold Ring | 13445 | WORKS | HP+5 MP-5 -- matches bg-wiki exactly |
| Gold Ring +1 | 13520 | WORKS | HP+6 MP-6 -- matches bg-wiki exactly |
| Platinum Ring | 13447 | WORKS | HP+8 MP-8 -- matches bg-wiki exactly |
| Platinum Ring +1 | 13498 | WORKS | HP+9 MP-7 -- matches bg-wiki exactly |

### Leathercraft

| Item | ID | Status | Notes |
|------|-----|--------|-------|
| Raptor Mantle | 13593 | WORKS | DEF:6 Fire+3 Water-1 -- matches bg-wiki exactly |
| Tiger Stole | 13119 | WORKS | DEF:2 ATT+5 -- matches bg-wiki exactly |

### Bonecraft

| Item | ID | Status | Notes |
|------|-----|--------|-------|
| Bone Earring | 13321 | WORKS | ATT+1 EVA-1 -- matches bg-wiki exactly |
| Bone Earring +1 | 13362 | WORKS | ATT+2 EVA-1 -- matches bg-wiki exactly |
| Smilodon Mantle | 16231 | WORKS | DEF:9 STR+4 -- matches bg-wiki exactly |
| Smilodon Mantle +1 | 16232 | WORKS | DEF:10 STR+5 -- matches bg-wiki exactly |

### Clothcraft

| Item | ID | Status | Notes |
|------|-----|--------|-------|
| Baron's Saio | 14447 | WORKS | DEF:15 INT+1 MND+1 -- matches bg-wiki exactly. HQ of Trader's Saio (Clothcraft 25 / Leathercraft 9) |
| Blessed Bliaut | 14436 | WORKS | DEF:41 MPP+7% MND+5 Enmity-5 Barspell MDB+5 -- matches bg-wiki exactly. Recipe exists (Clothcraft 102) |
| Blessed Bliaut +1 | 14438 | WORKS | DEF:42 MPP+8% MND+6 Enmity-6 Barspell MDB+5 -- matches bg-wiki exactly |
| Blessed Mitts | 14875 | WORKS | DEF:18 MP+15 MND+7 Enmity-3 Haste 5% (500) -- matches bg-wiki exactly. Recipe exists (Clothcraft 96) |
| Blessed Mitts +1 | 14877 | WORKS | DEF:19 MP+18 MND+8 Enmity-4 Haste 6% (600) -- matches bg-wiki exactly |
| Blessed Pumps | 15329 | WORKS | DEF:14 MP+17 MND+3 Enmity-4 Haste 2% (200) -- matches bg-wiki exactly. Recipe exists (Leathercraft 99 / Clothcraft 55) |
| Blessed Pumps +1 | 15331 | WORKS | DEF:15 MP+20 MND+4 Enmity-5 Haste 3% (300) -- matches bg-wiki exactly |

### Alchemy (Vile Elixirs)

| Item | ID | Status | Notes |
|------|-----|--------|-------|
| Vile Elixir | 4174 | WORKS | NOT craftable (drop/NPC purchase). Script restores 25% HP + 25% MP -- matches bg-wiki exactly |
| Vile Elixir +1 | 4175 | WORKS | NOT craftable (drop/NPC purchase). Script restores 55% HP + 55% MP -- matches bg-wiki exactly |

**Note:** Vile Elixirs are NOT crafted via alchemy. They are obtained from NPC vendors (Curio Vendor Moogle), monster drops, and quest rewards. No synth recipe exists in the server, which is correct per retail.

## Detailed Mod Verification

### Server Values vs bg-wiki (mod-by-mod)

**Darksteel Harness (12580):**
| Mod | Server | bg-wiki | Match? |
|-----|--------|---------|--------|
| DEF (1) | 39 | 39 | YES |
| LIGHT_MEVA (21) | 2 | 2 | YES |
| DARK_MEVA (22) | 2 | 2 | YES |
| DMGPHYS (161) | -300 (-3%) | -3% | YES |
| DMGRANGE (164) | -300 (-3%) | (included in "Physical") | YES |

**Hauberk +1 (13793):**
| Mod | Server | bg-wiki | Match? |
|-----|--------|---------|--------|
| DEF (1) | 48 | 48 | YES |
| STR (8) | 6 | 6 | YES |
| DEX (9) | 6 | 6 | YES |
| ATT (23) | 12 | 12 | YES |
| ACC (25) | 12 | 12 | YES |
| EVA (68) | -10 | -10 | YES |

**Blessed Bliaut (14436):**
| Mod | Server | bg-wiki | Match? |
|-----|--------|---------|--------|
| DEF (1) | 41 | 41 | YES |
| MPP (6) | 7 | 7% | YES |
| MND (13) | 5 | 5 | YES |
| ENMITY (27) | -5 | -5 | YES |
| BARSPELL_MDEF_BONUS (827) | 5 | 5 | YES |

**Blessed Mitts (14875):**
| Mod | Server | bg-wiki | Match? |
|-----|--------|---------|--------|
| DEF (1) | 18 | 18 | YES |
| MP (5) | 15 | 15 | YES |
| MND (13) | 7 | 7 | YES |
| ENMITY (27) | -3 | -3 | YES |
| HASTE_GEAR (384) | 500 (5%) | 5% | YES |

**Adaman Hauberk (12557) - from Cursed Hauberk abjuration:**
| Mod | Server | bg-wiki | Match? |
|-----|--------|---------|--------|
| DEF (1) | 53 | 53 | YES |
| STR (8) | 10 | 10 | YES |
| DEX (9) | 10 | 10 | YES |
| ATT (23) | 15 | 15 | YES |
| ACC (25) | 15 | 15 | YES |
| EVA (68) | -10 | -10 | YES |

## Blockers
- None found. All items verified correct.

## Fix Difficulty
- N/A -- no fixes needed.
