# Expansion Mission Reward Equipment Audit

> Audited: 2026-03-28
> Scope: All expansion mission equipment rewards — existence, mods, and mission script granting

---

## Summary

| Expansion | Items Checked | WORKS | ISSUE | NOT IMPLEMENTED |
|-----------|:------------:|:-----:|:-----:|:---------------:|
| COP       | 10           | 7     | 1     | 2               |
| ZM        | 5            | 5     | 0     | 0               |
| ToAU      | 3            | 2     | 1     | 0               |
| WotG      | 1            | 1     | 0     | 0               |
| SoA       | 21           | 12    | 6     | 3               |
| RoV       | 0            | --    | --    | --              |
| **TOTAL** | **40**       | **27**| **8** | **5**           |

---

## COP (Chains of Promathia)

### 8-4 Dawn — Ring Rewards

| Item | ID | item_basic | item_mods | Script Awards | Status |
|------|---:|:----------:|:---------:|:-------------:|:------:|
| Rajas Ring | 15543 | YES | YES (STR+2, DEX+2, Store TP+5, Subtle Blow+5) | YES (`cop/8_4_Dawn.lua`) | WORKS |
| Tamas Ring | 15544 | YES | YES (HP+15, VIT+2, AGI+2, Enmity+3) | YES (`cop/8_4_Dawn.lua`) | WORKS |
| Sattva Ring | 15545 | YES | YES (MP+15, INT+2, MND+2, Enmity-3) | YES (`cop/8_4_Dawn.lua`) | WORKS |

### Apocalypse Nigh — Earring Rewards (Post-COP quest)

| Item | ID | item_basic | item_mods | Script Awards | Status |
|------|---:|:----------:|:---------:|:-------------:|:------:|
| Static Earring | 15962 | YES | YES (MND+2, MDEF+2, Magic Burst Bonus+5) | YES (`quests/jeuno/Apocalypse_Nigh.lua`) | WORKS |
| Magnetic Earring | 15963 | YES | YES (MP+20, MP Heal+1, Spell Interrupt-8%, Conserve MP+5) | YES (same) | WORKS |
| Hollow Earring | 15964 | YES | YES (DEX+2, ACC+3, RACC+3, Enspell DMG+3) | YES (same) | WORKS |
| Ethereal Earring | 15965 | YES | YES (HP+15, ATT+5, EVA+5, Absorb DMG to MP+3) | YES (same) | WORKS |

### 7-1 Chains and Bonds — Ducal Guard's Ring

| Item | ID | item_basic | item_mods | Script Awards | Status |
|------|---:|:----------:|:---------:|:-------------:|:------:|
| Ducal Guard's Ring | 14657 | YES | **NO MODS** | YES (`cop/7_1_Chains_and_Bonds.lua`) | NOT IMPLEMENTED |

**Detail:** On retail, Ducal Guard's Ring has "Latent Effect: Refresh" which activates while on a COP
mission. The server has no latent condition for "during COP mission" (the LATENT enum in
`src/map/latent_effect.h` has no such type). This is an upstream LandSandBoat limitation.
The ring will equip but provide no stats.

### 8-1 Garden of Antiquity — Tavnazian Ring

| Item | ID | item_basic | item_mods | Script Awards | Status |
|------|---:|:----------:|:---------:|:-------------:|:------:|
| Tavnazian Ring | 14672 | YES | **NO MODS** | YES (`cop/8_1_Garden_of_Antiquity.lua`) | NOT IMPLEMENTED |

**Detail:** On retail, Tavnazian Ring has "Latent Effect: Regen" (activates in Tavnazian areas).
No applicable latent condition exists in the server. Same upstream limitation as Ducal Guard's Ring.

---

## ZM (Zilart Missions) — Divine Might Quest

The Zilart mission line itself grants no equipment. The Divine Might side-quest (requires ZM14+)
rewards one of five earrings. Script: `scripts/quests/outlands/Divine_Might.lua`

| Item | ID | item_basic | item_mods | Script Awards | Status |
|------|---:|:----------:|:---------:|:-------------:|:------:|
| Suppanomimi | 14739 | YES | YES (AGI+2, Sword+5, Dual Wield+5) | YES | WORKS |
| Knight's Earring | 14740 | YES | YES (VIT+2, Shield+5, Divine+5) | YES | WORKS |
| Abyssal Earring | 14741 | YES | YES (INT+2, Scythe+5, Dark+5) | YES | WORKS |
| Beastly Earring | 14742 | YES | YES (CHR+2, Eva+5, Axe+5) | YES | WORKS |
| Bushinomimi | 14743 | YES | YES (STR+2, Great Katana+5, Parry+5) | YES | WORKS |

**Note:** Brutal Earring (14813), Colossus's Earring (16058), and Reraise Earring (14790) are NOT
Divine Might rewards. Brutal is from the Desire for Glory BCNM, Colossus's from Assault,
and Reraise from the Eldieme Necropolis quest.

---

## ToAU (Treasures of Aht Urhgan)

### Mission 46 — Imperial Coronation Ring Rewards

Script: `scripts/missions/toau/46_Imperial_Coronation.lua`

| Item | ID | item_basic | item_mods | Script Awards | Status |
|------|---:|:----------:|:---------:|:-------------:|:------:|
| Balrahn's Ring | 15807 | YES | **INCOMPLETE** (MACC+4 only) | YES | ISSUE |
| Ulthalam's Ring | 15808 | YES | YES (ATT+4, ACC+4) | YES | WORKS |
| Jalzahn's Ring | 15809 | YES | YES (RATT+6, RACC+6) | YES | WORKS |

**Balrahn's Ring ISSUE:** On retail, Balrahn's Ring has MACC+4 AND Enmity-2. The server only has
MACC+4. Missing mod: `(15807, 27, -2) -- ENMITY: -2`

**Other ToAU reward:** Imperial Standard (ID 129) is furniture, not equipment. No mods expected.

---

## WotG (Wings of the Goddess)

### Mission 54 — Lest We Forget — Moonshade Earring

| Item | ID | item_basic | item_mods | Script Awards | Status |
|------|---:|:----------:|:---------:|:-------------:|:------:|
| Moonshade Earring | 11697 | YES | None (augment-only item) | YES (`wotg/54_Lest_We_Forget.lua`) | WORKS |

**Detail:** Moonshade Earring is an augment-only item. The mission script (`wotg/54_Lest_We_Forget.lua`)
correctly applies augments via `player:addItem()` with augment parameters. Player chooses two augments:

First augment (choose 1): ACC+4, ATK+4, RACC+4, RATK+4, MACC+4, MAB+4, HP+25, or MP+25
Second augment (choose 1): Regain+10, Refresh+1, TP Bonus+250, various proc effects

No base mods in item_mods.sql is correct behavior — all stats come from augments.

**Note:** WotG Mission 51 (Maiden of the Dusk) grants the Moonshade Earring KEY ITEM, not
the equipment. The actual earring is obtained in Mission 54 via the Veridical Conflux in Grauberg [S].

---

## SoA (Seekers of Adoulin)

### Mission 4-3-8 — The Lightsland — Back Piece Rewards

Script: `scripts/missions/soa/4_3_8_The_Lightsland.lua`

| Item | ID | item_basic | item_mods | Script Awards | Status |
|------|---:|:----------:|:---------:|:-------------:|:------:|
| Adoulin's Refuge | 28376 | YES | **NO MODS** | YES | ISSUE |
| Ygnas's Resolve | 28377 | YES | **NO MODS** | YES | ISSUE |
| Arciela's Grace | 28378 | YES | **NO MODS** | YES | ISSUE |

**Detail:** These back pieces should have base stats on retail:
- Adoulin's Refuge: DEF:10 HP+30 MP+30
- Ygnas's Resolve: DEF:10 STR+5 DEX+5 VIT+5 AGI+5 INT+5 MND+5 CHR+5
- Arciela's Grace: DEF:10 ACC+15 EVA+15

All three are completely statless. This is an upstream LSB gap.

### Mission 4-6-1 — The Charlatan — Back Piece +1 Rewards

Script: `scripts/missions/soa/4_6_1_The_Charlatan.lua`

| Item | ID | item_basic | item_mods | Script Awards | Status |
|------|---:|:----------:|:---------:|:-------------:|:------:|
| Adoulin's Refuge +1 | 28367 | YES | **NO MODS** | YES | ISSUE |
| Ygnas's Resolve +1 | 28368 | YES | **NO MODS** | YES | ISSUE |
| Arciela's Grace +1 | 28369 | YES | **NO MODS** | YES | ISSUE |

**Detail:** +1 versions should have enhanced stats over base versions. Same upstream gap.

### Mission 5-5-1 — The Light Within — Ring + Cosmetic Rewards

Script: `scripts/missions/soa/5_5_1_The_Light_Within.lua`

| Item | ID | item_basic | item_mods | Script Awards | Status |
|------|---:|:----------:|:---------:|:-------------:|:------:|
| Adoulin Ring | 27580 | YES | YES (8 mods: HP/MP+50, ATT/RATT+15, ACC/RACC+5, MATT+7, MACC+5) | YES | WORKS |
| Woltaris Ring | 27581 | YES | YES (Refresh+1, Regen+1, Sublimation+1) | YES | WORKS |
| Weatherspoon Ring | 27582 | YES | YES (MACC+10, Light MAB+10, Fast Cast+5, Quick Magic+4) | YES | WORKS |
| Janniston Ring | 27583 | YES | YES (MP+40, Enmity-7, Cure Potency II+5) | YES | WORKS |
| Renaye Ring | 27584 | YES | YES (Singing+10, Blue Magic+10, Refresh+1) | YES | WORKS |
| Gorney Ring | 27585 | YES | YES (Steal+2, TH+1, Gilfinder+1) | YES | WORKS |
| Haverton Ring | 27586 | YES | YES (RACC+20, Ninjutsu+10, Dual Wield+5, Snapshot+6) | YES | WORKS |
| Karieyh Ring | 27587 | YES | YES (WS ACC+5, Regain+5, WS DMG+3) | YES | WORKS |
| Vocane Ring | 27588 | YES | YES (PDT-7%, Cure Potency Rcvd+5, Knockback Reduction+2) | YES | WORKS |
| Thurandaut Ring | 27589 | YES | **NO MODS** | YES | NOT IMPLEMENTED |
| Shneddick Ring | 27590 | YES | YES (Move Speed+18%, Petrify/Bind/Gravity Resist+15) | YES | WORKS |
| Orvail Ring | 27591 | YES | YES (Synth Success+1, Skill Gain+5, Material Loss+1, HQ Rate+1) | YES | WORKS |
| Councilor's Garb | 27923 | YES | Latent only (Move Speed in Adoulin) | YES | WORKS |
| Councilor's Cuffs | 28063 | YES | None (cosmetic vanity item) | YES | WORKS |

**Thurandaut Ring ISSUE:** On retail, Thurandaut Ring has Pet: ACC+5, RACC+5, MAB+3, MACC+5.
The ring has zero mods in the server. This is an upstream LSB gap — pet-related ring stats missing.

---

## RoV (Rhapsodies of Vana'diel)

RoV missions grant **no equipment rewards**. The rewards are:
- Rhapsody Key Items (already verified in separate audit)
- Trust ciphers: Cipher of Tenzen II (Mission 2-2), Cipher of Prishe II (Mission 2-3)
- Copper A.M.A.N. Voucher (Mission 1-4)

No equipment audit needed for RoV.

---

## Issues Summary

### ISSUE: Missing/Incomplete Mods (fixable)

| Priority | Item | ID | Problem | Fix |
|:--------:|------|---:|---------|-----|
| LOW | Balrahn's Ring | 15807 | Missing Enmity-2 | Add `(15807, 27, -2)` to item_mods.sql |
| MED | Adoulin's Refuge | 28376 | No mods at all | Add DEF, HP+30, MP+30 |
| MED | Ygnas's Resolve | 28377 | No mods at all | Add DEF, all stats +5 |
| MED | Arciela's Grace | 28378 | No mods at all | Add DEF, ACC+15, EVA+15 |
| MED | Adoulin's Refuge +1 | 28367 | No mods at all | Add enhanced DEF, HP+50, MP+50 |
| MED | Ygnas's Resolve +1 | 28368 | No mods at all | Add enhanced DEF, all stats +7 |
| MED | Arciela's Grace +1 | 28369 | No mods at all | Add enhanced DEF, ACC+20, EVA+20 |
| LOW | Thurandaut Ring | 27589 | No mods (pet stats) | Add Pet: ACC+5, RACC+5, MAB+3, MACC+5 |

### NOT IMPLEMENTED: Missing Latent Conditions (upstream limitation)

| Item | ID | Problem |
|------|---:|---------|
| Ducal Guard's Ring | 14657 | Needs "during COP mission" latent (does not exist in server) |
| Tavnazian Ring | 14672 | Needs "in Tavnazian area" latent (does not exist in server) |
| Thurandaut Ring +1 | 26201 | Pet stats not implemented (same as base version) |

### All Mission Scripts Verified

Every mission that awards equipment was confirmed to have a working `npcUtil.giveItem()` or
`player:addItem()` call in the correct mission script. No script-level issues found —
all items are properly granted when the mission is completed.

---

## Key File Paths

- COP 8-4 Dawn: `scripts/missions/cop/8_4_Dawn.lua`
- COP 7-1 Chains and Bonds: `scripts/missions/cop/7_1_Chains_and_Bonds.lua`
- COP 8-1 Garden of Antiquity: `scripts/missions/cop/8_1_Garden_of_Antiquity.lua`
- Apocalypse Nigh: `scripts/quests/jeuno/Apocalypse_Nigh.lua`
- Divine Might: `scripts/quests/outlands/Divine_Might.lua`
- ToAU 46: `scripts/missions/toau/46_Imperial_Coronation.lua`
- WotG 54 Lest We Forget: `scripts/missions/wotg/54_Lest_We_Forget.lua`
- SoA 4-3-8 The Lightsland: `scripts/missions/soa/4_3_8_The_Lightsland.lua`
- SoA 4-6-1 The Charlatan: `scripts/missions/soa/4_6_1_The_Charlatan.lua`
- SoA 5-5-1 The Light Within: `scripts/missions/soa/5_5_1_The_Light_Within.lua`
- Item mods: `sql/item_mods.sql`
- Item latents: `sql/item_latents.sql`
- Latent effect types: `src/map/latent_effect.h`
