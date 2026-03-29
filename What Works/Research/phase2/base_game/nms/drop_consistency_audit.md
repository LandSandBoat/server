# Mob Drop Consistency Audit

**Date:** 2026-03-28
**Scope:** Cross-reference mob families with their droplists to find items that do not belong to the mob's ecosystem.
**Method:** Parsed `mob_groups.sql`, `mob_pools.sql`, `mob_family_system.sql`, `mob_droplist.sql`, `item_basic.sql`, and `zone_settings.sql`. Mapped droplistID -> poolID -> familyID -> ecosystem, then checked items against expected ecosystem drops.

**Dataset:** 14,833 mob groups, 7,285 mob pools, 400 families, 2,985 unique droplists, 22,610 items.

---

## AUDIT PLAN

| # | Check | Status |
|---|-------|--------|
| 1 | Diremites (family 84) dropping Lizard Blood (2013) | PASS |
| 2 | Undead mobs dropping beast/vermin materials | PASS (1 NM exception, retail-accurate) |
| 3 | Crab mobs (family 77) dropping non-crab items | PASS (all NM-specific drops, retail-accurate) |
| 4 | Bee/Wasp mobs missing Beehive Chip (912) / Honey (4370) | PASS (NMs only, by design) |
| 5 | Phomiuna Aqueducts (zone 27) full audit | PASS |
| 6 | Spot-check 5 target zones | PASS (1 false-positive flagged) |
| 7 | Shared droplists across incompatible ecosystems | PASS (Dynamis/Limbus/Einherjar only) |

---

## Check 1: Diremites (Family 84) Dropping Lizard Blood (Item 2013)

**Result: PASS -- No issues found.**

No Diremite mob in the database drops Lizard Blood. All Diremite droplists contain ecosystem-appropriate items (bloodthread, avatar blood, fiend blood).

---

## Check 2: Undead Mobs Dropping Beast/Vermin Materials

**Result: PASS -- 1 finding, retail-accurate (not an error).**

Checked all undead-ecosystem mobs (Skeleton, Ghost, Zombie, Corse, Draugar, Vampyr, Fomor, Doomed, Qutrub, etc.) for the presence of beast/vermin material items:
- Lizard_Skin (852), Lizard_Tail (881), Lizard_Blood (2013)
- Rabbit_Hide (896), Sheepskin (856), Dhalmel_Hide (854)
- Tiger_Hide (846), Ram_Skin (859), Wolf_Hide (842)
- Cockatrice_Skin (868), Coeurl_Meat (1112), Bugard_Skin (862)
- Beehive_Chip (912), Honey (4370)

**Initial false-positive note:** Item 880 is **Bone_Chip**, not Lizard_Skin. All 65 skeleton mobs dropping Bone_Chip (880) is correct behavior. Similarly, item 849 (Undead_Skin) is a legitimate undead-crafting material.

### Only finding:

| Mob | Family | Zone | Droplist | Item |
|-----|--------|------|----------|------|
| Lord_Ruthven | Vampyr | Beaucedine_Glacier | 3186 | Ram_Skin (859) |

**Verdict:** Lord_Ruthven is a Campaign-era NM with an extensive treasure pool including logs, ores, ingots, hides, and crafting materials. This is a standard "NM treasure pool" pattern used across all Campaign NMs regardless of ecosystem. **Retail-accurate, not an error.**

---

## Check 3: Crab Mobs Dropping Non-Crab Items

**Result: PASS -- All findings are NM-specific drops or special content, retail-accurate.**

After filtering out Dynamis, Limbus (Temenos/Apollyon), Abyssea, Salvage, Einherjar, and other special zones, 41 items were flagged across crab droplists. All belong to Named Monsters (NMs) with unique, non-generic drops:

| NM | Zone | Items | Notes |
|----|------|-------|-------|
| Krabkatoa | East_Ronfaure_[S] | Logs, ram_skin, wyvern_skin, raxa, etc. | Campaign NM treasure pool |
| King_Arthro | Jugner_Forest / Everbloom_Hollow | Avalon Shield, Avalon Breastplate, Damascene Cloth, Magic Cuisses, Velocious Belt | HNM-specific drops |
| Bubbly_Bernie | South_Gustaberg | Steam Clock (550) | NM-specific rare drop |
| Aquarius | The_Boyahda_Tree | Fransisca (17925) | NM weapon drop |
| Cancer | Kuftal_Tunnel | Arondight (16945) | NM weapon drop |
| Duke_Decapod | East_Sarutabaruta | Pelte (16185) | NM shield drop |
| Cargo_Crab_Colin | Korroloka_Tunnel | Nadrs (17650) | NM weapon drop |
| Soot_Crab / River_Crab | Zeruhn_Mines | Zeruhn_Soot (560) | Zone-thematic material |

**Verdict:** All are retail-accurate NM drops. No data errors.

---

## Check 4: Bee/Wasp Mobs Missing Beehive Chip (912) / Honey (4370)

**Result: PASS -- 9 of 28 unique bee droplists missing expected items, all are NMs or special content.**

Correct item IDs: Beehive_Chip = 912, Honey = 4370 (NOT 925, which is Giant_Stinger).

| Droplist | Mob | Zone | Missing | Context |
|----------|-----|------|---------|---------|
| 2860 | Arboricole_Hornet | Apollyon | Both | Limbus; drops Ancient Beastcoin only |
| 1795 | Nightmare_Hornet | Dynamis-Tavnazia | Both | Dynamis; drops relic -1 gear |
| 2267 | Skirmish_Pephredo | Bhaflau_Remnants | Both | Salvage; drops cell items |
| 3297 | Erle | Rolanberry_Fields_[S] | Both | Campaign NM; drops unique weapon |
| 3000 | Numbing_Norman | West_Sarutabaruta | Both | NM; drops Pike |
| 3068 | Powderer_Penny | Yhoator_Jungle | Both | NM; drops Chary Earring |
| 457 | Chasmic_Hornet | Abyssea-La_Theine | Both | Abyssea NM |
| 583 | Death_from_Above | Temple_of_Uggalepih | Chip only | NM; has Honey, Royal Jelly, HornetNeedle |
| 610 | Demonic_Tiphia | Crawlers_Nest | Both | NM; drops Tiphia Sting + Royal Jelly |

**Verdict:** All 19 normal-spawn bee droplists correctly contain both Beehive Chip and Honey. The 9 missing droplists are all NMs or special-content mobs that have unique drop tables by design. **Retail-accurate.**

---

## Check 5: Phomiuna Aqueducts (Zone 27) Full Audit

**Result: PASS -- No data errors found.**

44 mob groups in zone. Mob families present:
- **Undead:** Doomed (Addled_Tumor, Foul_Meat), Fomor (12 job variants + Duendes_Amoroso + Eba)
- **Vermin:** Spider (Aqueduct_Spider), Diremite
- **Aquan:** Pugil (Big_Jaw, Makara)
- **Amorph:** Slime (Freshwater_Trepang, Gloop, Sponge, Water_Pumpkin, Oil_Spill, Bavarois, Ogreish_Risotto)
- **Bird:** Bat, Bat_Trio (Canal_Bats, Hell_Bat, Vampire_Bat, Tres_Duendes)
- **Demon:** Tauri (Taurus, Stegotaur, Mahisha, Minotaur)
- **Elemental:** Air, Dark, Thunder

All drops are ecosystem-appropriate:
- Doomed drop Undead_Skin (849) -- correct crafting material
- Fomors drop zodiac Subligars, Bronze Key, Revival Tree Root -- correct Fomor drops
- Spiders drop Water Spider Web, Rainbow Thread, Spider Web -- correct
- Pugils drop Silica, Pugil Scales, Fish Scales -- correct
- Slimes drop Slime Oil -- correct
- Bats drop Bat Wing, Bat Fang, Fiend Blood, Beastman Blood -- correct
- Taurus drop Spruce Lumber, Fomor Codex, Taurus Horn, Demon Skull/Horn -- correct

---

## Check 6: Spot-Check of 5 Target Zones

**Result: PASS -- No real data errors found.**

### The Boyahda Tree (zone 153) -- 41 mob groups
No cross-ecosystem issues. All drops match mob families.

### Temple of Uggalepih (zone 159) -- 52 mob groups
One false-positive: Death_from_Above (Bee NM) has "hornetneedle" flagged because "horn" matched the keyword filter. HornetNeedle is a bee-specific weapon drop. **Not an error.**

### Crawlers' Nest [S] (zone 171) -- 122 mob groups
No issues found.

### Sea Serpent Grotto (zone 176) -- 65 mob groups
No issues found.

### Crawlers' Nest (zone 197) -- 40 mob groups
No issues found.

### Garlaige Citadel (zone 200) -- 48 mob groups
Doomed mobs (Fetid_Flesh, Tainted_Flesh) drop Undead_Skin (849). Initially flagged due to "skin" keyword, but Undead_Skin is a legitimate undead crafting material. **Not an error.**

---

## Check 7: Droplists Shared Across Incompatible Ecosystems

**Result: PASS -- 18 shared droplists found, all in special content zones (by design).**

All shared droplists fall into three categories:

### Dynamis (12 shared droplists)
Droplists 1785, 1787, 1788, 1789, 1790, 1791, 1794, 1798, 1799, 1800, 3123, 3124
- Nightmare mobs of different ecosystems share relic -1 equipment and Dynamis currency drops
- This is retail-accurate: Dynamis mobs are grouped by drop pool, not by ecosystem

### Limbus (3 shared droplists)
Droplists 2856, 2858, 3237
- Temenos/Apollyon mobs all drop Ancient Beastcoin regardless of ecosystem
- Retail-accurate

### Einherjar (1 shared droplist)
Droplist 3410
- Hazhalm Testing Grounds mobs all drop Page from Balrahn's Reflections
- Retail-accurate

### Limbus + Mixed (2 shared droplists)
Droplist 2860: Avatars, Bees, Spiders, Opo-opo, Saplings in Apollyon -- all drop Ancient Beastcoin

**Verdict:** All cross-ecosystem shared droplists are in special instanced content where drops are determined by content type, not mob ecosystem. **Retail-accurate.**

---

## Summary

| # | Check | Findings | Real Errors |
|---|-------|----------|-------------|
| 1 | Diremite / Lizard Blood | 0 | **0** |
| 2 | Undead / Beast Materials | 1 (Lord_Ruthven) | **0** (NM treasure pool) |
| 3 | Crab / Non-Crab Items | 41 (after filtering) | **0** (all NM drops) |
| 4 | Bee / Missing Drops | 9 of 28 droplists | **0** (all NMs/special) |
| 5 | Phomiuna Aqueducts | 0 | **0** |
| 6 | Zone Spot-Checks | 1 false positive | **0** |
| 7 | Cross-Eco Shared Droplists | 18 | **0** (Dynamis/Limbus/Einherjar) |
| **Total** | | | **0 data errors** |

## Conclusion

**No mob drop data errors were found.** The LandSandBoat database is consistent in its mob-to-drop family mappings:

1. All normal-spawn mobs drop items appropriate to their ecosystem/family.
2. NMs correctly have unique drop tables with weapons, armor, and rare items regardless of mob family.
3. Campaign NMs use standardized treasure pool patterns (logs, ores, hides, crafting materials).
4. Special content (Dynamis, Limbus, Salvage, Einherjar, Abyssea) uses content-specific drop tables shared across ecosystems, which is retail-accurate behavior.

### Key Item ID Reference (corrected during audit)
| Item | Correct ID | Commonly confused with |
|------|-----------|----------------------|
| Bone_Chip | 880 | Often mistaken for Lizard_Skin (852) |
| Beehive_Chip | 912 | Often mistaken for Giant_Stinger (925) |
| Undead_Skin | 849 | Legitimate undead drop, not a beast material |
| Lizard_Skin | 852 | -- |
| Ram_Skin | 859 | -- |

---

*Audited by automated script cross-referencing mob_groups.sql, mob_pools.sql, mob_family_system.sql, mob_droplist.sql, item_basic.sql, and zone_settings.sql.*
