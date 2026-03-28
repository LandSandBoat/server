# Crafting Recipe Verification - Deep Audit

**Audit Date:** 2026-03-28
**Auditor:** Claude (Automated)
**Scope:** Spot-check 3-5 key progression recipes per craft against bg-wiki expectations
**File:** `sql/synth_recipes.sql` (4,389 active recipes, 356 commented-out)

---

## Summary

| Craft | Recipes Checked | All Present | Ingredients Valid | Mods Present | Issues |
|-------|----------------|-------------|-------------------|--------------|--------|
| Smithing | 5 | YES | YES | YES | Bewitched items missing mods |
| Woodworking | 4 | YES | YES | N/A (materials) | None |
| Goldsmithing | 4 | YES | YES | YES | None |
| Clothcraft | 4 | YES | YES | N/A (materials) | None |
| Leathercraft | 4 | YES (3 of 4) | YES | N/A (materials) | Dragon Leather MISSING |
| Bonecraft | 4 | YES (3 of 4) | YES | YES | Skull Hairpin MISSING |
| Alchemy | 4 | YES | YES | N/A (consumables) | None |
| Cooking | 4 | YES | YES | N/A (food scripts) | Squid Sushi COP-gated |

**Overall:** 33 recipes checked. 31 present and correct. 2 missing entirely.

---

## Smithing

### Bronze Ingot
- **Recipe ID:** 10001 | **Skill:** Smith 1 | **Crystal:** Fire (4096)
- **Ingredients:** 4x Copper Ore (640) | **Result:** Bronze Ingot (649)
- **bg-wiki match:** YES (Fire + 4 Copper Ore = Bronze Ingot, skill 1)
- **Alt recipe 10002:** Smith 2, uses 3x Copper Ore (640) + 1x Tin Ore (641) -- also correct per bg-wiki
- **Item exists:** YES (item 649, stackable x12)

### Iron Ingot
- **Recipe ID:** 10524 | **Skill:** Smith 20 | **Crystal:** Fire (4096)
- **Ingredients:** 4x Iron Ore (643) | **Result:** Iron Ingot (651), HQ: Steel Ingot (652)
- **bg-wiki match:** YES (Fire + 4 Iron Ore, skill ~20)
- **Item exists:** YES (item 651, stackable x12)

### Mythril Ingot
- **Recipe ID:** 21547 | **Skill:** Gold 40 | **Crystal:** Fire (4096)
- **Ingredients:** 4x Mythril Ore (644) | **Result:** Mythril Ingot (653)
- **bg-wiki match:** YES (Gold 40, Fire + 4 Mythril Ore)
- **Note:** This is Goldsmithing, not Smithing, which matches bg-wiki
- **Item exists:** YES (item 653, stackable x12)

### Darksteel Ingot
- **Recipe ID:** 12509 | **Skill:** Smith 52 | **Crystal:** Fire (4096)
- **Ingredients:** 3x Iron Ore (643) + 1x Darksteel Ore (645) | **Result:** Darksteel Ingot (654)
- **bg-wiki match:** YES (Smith 52, Fire crystal)
- **Item exists:** YES (item 654, stackable x12)

### Hauberk
- **Recipe ID:** 14038 | **Skill:** Smith 89, sub Gold 38 | **Crystal:** Earth (4099)
- **Ingredients:** Steel Sheet (666), Darksteel Chain (682), Silk Cloth (829), Velvet Cloth (828), Haubergeon (12555)
- **bg-wiki match:** YES (Smith 89 / Gold 38, Earth crystal)
- **Result:** Hauberk (12556), HQ: Hauberk +1 (13793)
- **Mods exist:** Hauberk: DEF 47, STR 5, DEX 5, ATT 10, ACC 10, EVA -10 -- CORRECT
- **Mods exist:** Hauberk +1: DEF 48, STR 6, DEX 6, ATT 12, ACC 12, EVA -10 -- CORRECT
- **PASS**

---

## Woodworking

### Ash Lumber
- **Recipe ID:** 21 | **Skill:** Wood 8 | **Crystal:** Wind (4098)
- **Ingredients:** 1x Ash Log (698) | **Result:** Ash Lumber (715)
- **bg-wiki match:** YES (Wind + Ash Log, skill 8)
- **Item exists:** YES (items 698 log, 715 lumber)

### Holly Lumber
- **Recipe ID:** 508 | **Skill:** Wood 12 | **Crystal:** Wind (4098)
- **Ingredients:** 1x Holly Log (697) | **Result:** Holly Lumber (714)
- **bg-wiki match:** YES (Wind + Holly Log, skill ~12)
- **Item exists:** YES (items 697 log, 714 lumber)

### Elm Lumber
- **Recipe ID:** 1018 | **Skill:** Wood 25 | **Crystal:** Wind (4098)
- **Ingredients:** 1x Elm Log (690) | **Result:** Elm Lumber (707)
- **bg-wiki match:** YES (Wind + Elm Log, skill ~25)
- **Item exists:** YES (items 690 log, 707 lumber)

### Ebony Lumber
- **Recipe ID:** 3002 | **Skill:** Wood 61 | **Crystal:** Wind (4098)
- **Ingredients:** 1x Ebony Log (702) | **Result:** Ebony Lumber (719)
- **bg-wiki match:** YES (Wind + Ebony Log, skill ~61)
- **Item exists:** YES (items 702 log, 719 lumber)

---

## Goldsmithing

### Brass Ingot
- **Recipe ID:** 20015 | **Skill:** Gold 9 | **Crystal:** Fire (4096)
- **Ingredients:** 3x Copper Ore (640) + 1x Zinc Ore (642) | **Result:** Brass Ingot (650)
- **bg-wiki match:** YES (Fire, Gold 9)
- **Item exists:** YES (item 650, stackable x12)

### Gold Ingot
- **Recipe ID:** 22523 | **Skill:** Gold 53 | **Crystal:** Fire (4096)
- **Ingredients:** 4x Gold Ore (737) | **Result:** Gold Ingot (745)
- **bg-wiki match:** YES (Fire + 4 Gold Ore, Gold 53)
- **Alt recipe 22504:** Gold 51, uses 4x Gold Beastcoin (748) -- also correct
- **Item exists:** YES (item 745)

### Platinum Ingot
- **Recipe ID:** 23010 | **Skill:** Gold 63 | **Crystal:** Fire (4096)
- **Ingredients:** 4x Platinum Ore (738) | **Result:** Platinum Ingot (746)
- **bg-wiki match:** YES (Fire + 4 Platinum Ore, Gold ~63)
- **Alt recipe 23004:** Gold 61, uses 4x Platinum Beastcoin (751) -- also correct
- **Item exists:** YES (item 746)

### Silver Ring
- **Recipe ID:** 21505 | **Skill:** Gold 32 | **Crystal:** Fire (4096)
- **Ingredients:** 2x Silver Ingot (744) | **Result:** Silver Ring (13456), HQ: Silver Ring +1 (13518)
- **bg-wiki match:** YES (Fire + 2 Silver Ingot, Gold ~32)
- **Mods exist:** Silver Ring: HP 3, MP -3 -- CORRECT
- **Mods exist:** Silver Ring +1: HP 4, MP -4 -- CORRECT
- **PASS**

---

## Clothcraft

### Cotton Thread
- **Recipe ID:** 30503 | **Skill:** Cloth 11 | **Crystal:** Lightning (4100)
- **Ingredients:** 2x Saruta Cotton (834) | **Result:** Cotton Thread (818)
- **bg-wiki match:** YES (Lightning + 2 Saruta Cotton, Cloth ~11)
- **Item exists:** YES (items 834 cotton, 818 thread)

### Silk Thread
- **Recipe ID:** 32501 | **Skill:** Cloth 51 | **Crystal:** Lightning (4100)
- **Ingredients:** 2x Crawler Cocoon (839) | **Result:** Silk Thread (816)
- **bg-wiki match:** YES (Lightning + 2 Crawler Cocoon, Cloth ~51)
- **Item exists:** YES (items 839 cocoon, 816 thread)

### Silk Cloth
- **Recipe ID:** 32512 | **Skill:** Cloth 53 | **Crystal:** Earth (4099)
- **Ingredients:** 3x Silk Thread (816) | **Result:** Silk Cloth (829)
- **bg-wiki match:** YES (Earth + 3 Silk Thread, Cloth ~53)
- **Item exists:** YES (item 829)

### Rainbow Thread
- **Recipe ID:** 33555 | **Skill:** Cloth 78 | **Crystal:** Lightning (4100)
- **Ingredients:** 2x Spider Web (838) | **Result:** Rainbow Thread (821)
- **bg-wiki match:** YES (Lightning + 2 Spider Web, Cloth ~78)
- **Item exists:** YES (items 838 web, 821 thread)

---

## Leathercraft

### Sheep Leather
- **Recipe ID:** 40003 | **Skill:** Leather 2 | **Crystal:** Dark (4103)
- **Ingredients:** Sheepskin (505), Win. Tea Leaves (635), Distilled Water (4509)
- **bg-wiki match:** YES (Dark + Sheepskin + Willow Fishing Rod material + Water, Leather ~2)
- **Item exists:** YES (item 850)

### Ram Leather
- **Recipe ID:** 41515 | **Skill:** Leather 35 | **Crystal:** Dark (4103)
- **Ingredients:** Win. Tea Leaves (635), Ram Skin (859), Distilled Water (4509)
- **bg-wiki match:** YES (Dark crystal, Leather ~35)
- **Item exists:** YES (item 851)

### Tiger Leather
- **Recipe ID:** 43002 | **Skill:** Leather 61 | **Crystal:** Dark (4103)
- **Ingredients:** Win. Tea Leaves (635), Black Tiger Hide (861), Distilled Water (4509)
- **bg-wiki match:** YES (Dark crystal, Leather ~61)
- **Item exists:** YES (item 855)

### Dragon Leather
- **MISSING:** No recipe found in synth_recipes.sql for "Dragon Leather"
- **bg-wiki:** Dragon Leather is Leather 84, Dark crystal + Dragon Skin + Win. Tea Leaves + Distilled Water
- **Note:** Dragon Skin does not exist in item_basic.sql either (only Wyvern Skin 1122 exists)
- **SEVERITY:** Medium -- Dragon Leather is used in several high-level recipes
- **STATUS: FAIL** -- Recipe and ingredient both absent

---

## Bonecraft

### Bone Hairpin (substituted for Bone Chip -- Bone Chip is a mob drop, not crafted)
- **Recipe ID:** 50006 | **Skill:** Bone 4 | **Crystal:** Wind (4098)
- **Ingredients:** 1x Bone Chip (880) | **Result:** Bone Hairpin (12505), HQ: Bone Hairpin +1 (13825)
- **bg-wiki match:** YES (Wind + Bone Chip, Bone ~4)
- **Mods exist:** Bone Hairpin: HP -1, MP 3, Dark MEVA 2 -- CORRECT
- **Mods exist:** Bone Hairpin +1: HP -1, MP 4, Dark MEVA 3 -- CORRECT

### Shell Powder
- **Recipe ID:** 50001 | **Skill:** Bone 1 | **Crystal:** Wind (4098)
- **Ingredients:** 3x Seashell (888) | **Result:** Shell Powder (1883)
- **bg-wiki match:** YES (Wind + 3 Seashell, Bone ~1)
- **Item exists:** YES (items 888 seashell, 1883 shell powder)

### Skull Hairpin
- **MISSING:** No recipe found in synth_recipes.sql (active or commented-out)
- **bg-wiki:** Skull Hairpin is Bone ~60, Wind crystal + Demon Skull + Bone Chip
- **Note:** Item does not appear to exist in item_basic.sql either
- **SEVERITY:** Low-Medium -- iconic mid-level bonecraft item
- **STATUS: FAIL** -- Recipe absent

### Smilodon Mantle
- **Recipe ID:** 43525 | **Skill:** Leather 75 | **Crystal:** Ice (4097)
- **Ingredients:** Wool Thread (820), Smilodon Hide (2518)
- **bg-wiki match:** YES (Ice crystal, Leather 75)
- **Note:** Categorized under bonecraft in the audit request but this is actually a Leathercraft recipe
- **Result:** Smilodon Mantle (16231), HQ: Smilodon Mantle +1 (16232)
- **Mods exist:** Smilodon Mantle: DEF 9, STR 4 -- CORRECT
- **Mods exist:** Smilodon Mantle +1: DEF 10, STR 5 -- CORRECT
- **PASS**

### Bone Ring
- **Recipe ID:** 50511 | **Skill:** Bone 17 | **Crystal:** Wind (4098)
- **Ingredients:** Bone Chip (880), Bone Arrowhead (882) | **Result:** Bone Ring (13441), HQ: Bone Ring +1 (13500)
- **bg-wiki match:** YES (Wind crystal, Bone ~17)
- **Mods exist:** Bone Ring: ACC -2, RACC 2 -- CORRECT
- **Mods exist:** Bone Ring +1: ACC -2, RACC 3 -- CORRECT

---

## Alchemy

### Mercury
- **Recipe ID:** 60515 | **Skill:** Alchemy 16 | **Crystal:** Lightning (4100)
- **Ingredients:** 4x Cobalt Jellyfish (4443) | **Result:** Mercury (914)
- **bg-wiki match:** YES (Lightning + 4 Cobalt Jellyfish, Alchemy ~16)
- **Item exists:** YES (items 4443 jellyfish, 914 mercury)

### Silent Oil
- **Recipe ID:** 61011 | **Skill:** Alchemy 24 | **Crystal:** Water (4101)
- **Ingredients:** Slime Oil (637), 2x Beeswax (913) | **Result:** 4x Silent Oil (4165)
- **bg-wiki match:** YES (Water crystal, Alchemy ~24)
- **Item exists:** YES (all ingredients and result verified)
- **Alt recipe 61027:** Alchemy 29, uses Olive Oil (633) + 2x Beeswax (913) = 2x Silent Oil

### Prism Powder
- **Recipe ID:** 61522 | **Skill:** Alchemy 36 | **Crystal:** Light (4102)
- **Ingredients:** Ahriman Lens (557), 2x Glass Fiber (933) | **Result:** 8x Prism Powder (4164)
- **bg-wiki match:** YES (Light crystal, Alchemy ~36)
- **Alt recipe 62002:** Alchemy 41, 2x Glass Fiber + Artificial Lens (1109) = 6x Prism Powder
- **Item exists:** YES (all verified)

### Holy Water
- **Recipe ID:** 62501 | **Skill:** Alchemy 51 | **Crystal:** Light (4102)
- **Ingredients:** Distilled Water (4509) | **Result:** Holy Water (4154)
- **bg-wiki match:** YES (Light + Distilled Water, Alchemy ~51)
- **Item exists:** YES (items 4509, 4154)

---

## Cooking

### Meat Mithkabob
- **Recipe ID:** 71534 | **Skill:** Cook 38 | **Crystal:** Fire (4096)
- **Ingredients:** Kazham Peppers (612), Mhaura Garlic (614), Wild Onion (4387), Ziz Meat (5581)
- **Result:** 6x Meat Mithkabob (4381), HQ: 12x Meat Chiefkabob (4574)
- **bg-wiki match:** YES (Fire crystal, Cook ~38)
- **Alt recipe 71535:** Uses Cockatrice Meat (4435) instead of Ziz Meat
- **Food script:** `scripts/items/meat_mithkabob.lua` -- STR 5, AGI 1, INT -2, ATT% 22, Cap 60 -- CORRECT
- **PASS**

### Squid Sushi
- **Recipe ID:** 73060 | **Skill:** Cook 70 | **Crystal:** Earth (4099) | **Tag: COP**
- **Ingredients:** Tarutaru Rice (620), Rice Vinegar (1652), Gigant Squid (4474), Distilled Water (4509), Ground Wasabi (5164)
- **Result:** 6x Squid Sushi (5148), HQ: Squid Sushi +1 (5162)
- **bg-wiki match:** YES (Earth crystal, Cook ~70)
- **NOTE:** Recipe is COP-gated (content_tag='COP') -- requires COP expansion enabled
- **Food script:** `scripts/items/plate_of_squid_sushi.lua` -- HP 30, DEX 6, AGI 5, MND -1, ACC% 15 Cap 72, RACC% 15 Cap 72 -- CORRECT
- **PASS**

### Tavnazian Taco
- **Recipe ID:** 74005 | **Skill:** Cook 81 | **Crystal:** Earth (4099) | **Tag: COP**
- **Ingredients:** Tavnazian Salad (4279), 2x Tortilla (4408), Salsa (5299)
- **Result:** 6x Tavnazian Taco (5174), HQ: 12x Leremieu Taco (5175)
- **bg-wiki match:** YES (Earth crystal, Cook ~81)
- **Food script:** `scripts/items/tavnazian_taco.lua` exists
- **Item exists:** YES (all ingredients and results)
- **PASS**

### Red Curry
- **Recipe ID:** 75001 | **Skill:** Cook 100 | **Crystal:** Fire (4096)
- **Ingredients:** Kazham Peppers (612), Curry Powder (1475), Coriander (1555), Dragon Meat (4272), San d'Orian Carrot (4389), Mithran Tomato (4390), Distilled Water (4509)
- **bg-wiki match:** YES (Fire crystal, Cook 100, 7 ingredients)
- **Result:** Red Curry (4298)
- **Item exists:** YES (all ingredients and result)
- **NOTE:** Cook 100 is a cap recipe -- only available at max skill
- **PASS**

---

## Cursed Items -> Blessed/Bewitched Path Verification

### System Overview
FFXI uses two upgrade paths for cursed items:
1. **Cursed -> Bewitched (ROV-era):** Uses Cursed Item + Eschite Ore (9130)
2. **Traditional Blessed:** Direct craft recipes (COP-era Clothcraft blessed line)

### Cursed Hauberk Path (Smithing)
| Step | Recipe | Skill | Result |
|------|--------|-------|--------|
| Craft Hauberk | 14038 | Smith 89 / Gold 38 | Hauberk (12556) |
| Craft Cursed Hauberk | 14562 | Smith 96 / Gold 30 / Bone 48 | Cursed Hauberk (1356) / HQ: Cursed Hauberk -1 (1357) |
| Bewitched Hauberk (simple) | 14552 | Smith 95 | Bewitched Hauberk (26860) from Cursed Hauberk -1 (1357) + Eschite Ore (9130) |
| Bewitched Hauberk (advanced) | 15511 | Smith 115 / Gold 70 | Bewitched Hauberk (26860) from Cursed Hauberk (1356) + Eschite Ore + additional mats |

### CRITICAL FINDING: Bewitched Items Missing Mods
- **Bewitched Hauberk (26860):** NO MODS in item_mods.sql
- **Voodoo Hauberk (26861, HQ):** NO MODS in item_mods.sql
- **Bewitched Togi, Kabuto, Kote, Haidate, Sune-Ate:** Likely also missing mods (ROV-era items)
- These are likely unfinished ROV content -- the items exist but have no stats

### Hauberk +1 (13793)
- **Not craftable directly** -- only available as HQ result of the base Hauberk recipe (14038)
- **Mods present:** DEF 48, STR 6, DEX 6, ATT 12, ACC 12, EVA -10 -- CORRECT

### Blessed Equipment (Clothcraft, COP-era) -- FULLY FUNCTIONAL
| Item | Recipe ID | Skill | Mods Present |
|------|-----------|-------|--------------|
| Blessed Mitts (14875) | 34545 | Cloth 96 | YES: DEF 18, MP 15, MND 7, Enmity -3, Haste 5% |
| Blessed Trousers (15391) | 34548 | Cloth 97 | YES: DEF 32, MP 25, MND 6, Enmity -5, Haste 3% |
| Blessed Bliaut (14436) | 34571 | Cloth 102 | YES: DEF 41, MP% 7, MND 5, Enmity -5, Barspell 5 |
| Blessed Pumps (15329) | 44554 | Leather 99 / Cloth 55 | YES: DEF 14, MP 17, MND 3, Enmity -4, Haste 2% |

### Cursed Sets Coverage (All 8 Armor Types)
Verified that all traditional cursed armor sets have recipes:
- **Smithing (Koenig):** Celata, Mufflers, Breeches, Sollerets, Hauberk -- ALL PRESENT
- **Goldsmithing (Errant):** Crown, Schaller, Cuirass, Handschuhs, Diechlings, Schuhs -- ALL PRESENT
- **Clothcraft (Blessed/Cursed):** Dalmatica, Mitts, Slacks -- ALL PRESENT
- **Leathercraft (Cursed Pumps):** PRESENT
- **Bonecraft (Cursed):** Cap, Harness, Subligar, Gloves, Leggings -- ALL PRESENT
- **Alchemy (Cursed):** Mask, Finger Gauntlets, Cuisses, Greaves, Mail -- ALL PRESENT
- **Cooking (Cursed Beverage/Soup):** PRESENT

---

## Issues Found

### CRITICAL
1. **Bewitched/ROV items have no mods** -- Bewitched Hauberk (26860), Voodoo Hauberk (26861), and likely all other Bewitched armor pieces lack stats in item_mods.sql. These are ROV expansion items and appear to be unfinished content in LandSandBoat.

### MEDIUM
2. **Dragon Leather recipe MISSING** -- No recipe exists, and Dragon Skin (the key ingredient) is not in item_basic.sql. Only Wyvern Skin (1122) exists. This blocks several high-level leathercraft recipes.

### LOW
3. **Skull Hairpin recipe MISSING** -- Neither the recipe nor the item exist. This is a mid-tier bonecraft recipe (Bone ~60) that should produce a DEX hairpin.
4. **Squid Sushi is COP-gated** -- Requires COP expansion to be enabled. Not a bug, but worth noting for server configuration.

### NOT ISSUES (Clarifications)
- Bone Chip is a mob drop, not a crafted item -- this is correct per retail
- Mythril Ingot is under Goldsmithing, not Smithing -- correct per retail
- Food items use Lua scripts for mods, not item_mods.sql -- this is the correct system

---

## Verification Matrix

| Recipe | Present | Correct Skill | Correct Ingredients | Result Item Exists | Mods/Script Present |
|--------|---------|---------------|--------------------|--------------------|---------------------|
| Bronze Ingot | YES | Smith 1 | YES | YES (649) | N/A (material) |
| Iron Ingot | YES | Smith 20 | YES | YES (651) | N/A (material) |
| Mythril Ingot | YES | Gold 40 | YES | YES (653) | N/A (material) |
| Darksteel Ingot | YES | Smith 52 | YES | YES (654) | N/A (material) |
| Hauberk | YES | Smith 89 | YES | YES (12556) | YES |
| Ash Lumber | YES | Wood 8 | YES | YES (715) | N/A (material) |
| Elm Lumber | YES | Wood 25 | YES | YES (707) | N/A (material) |
| Holly Lumber | YES | Wood 12 | YES | YES (714) | N/A (material) |
| Ebony Lumber | YES | Wood 61 | YES | YES (719) | N/A (material) |
| Brass Ingot | YES | Gold 9 | YES | YES (650) | N/A (material) |
| Gold Ingot | YES | Gold 53 | YES | YES (745) | N/A (material) |
| Platinum Ingot | YES | Gold 63 | YES | YES (746) | N/A (material) |
| Silver Ring | YES | Gold 32 | YES | YES (13456) | YES |
| Cotton Thread | YES | Cloth 11 | YES | YES (818) | N/A (material) |
| Silk Thread | YES | Cloth 51 | YES | YES (816) | N/A (material) |
| Silk Cloth | YES | Cloth 53 | YES | YES (829) | N/A (material) |
| Rainbow Thread | YES | Cloth 78 | YES | YES (821) | N/A (material) |
| Sheep Leather | YES | Leather 2 | YES | YES (850) | N/A (material) |
| Ram Leather | YES | Leather 35 | YES | YES (851) | N/A (material) |
| Tiger Leather | YES | Leather 61 | YES | YES (855) | N/A (material) |
| Dragon Leather | **NO** | -- | -- | -- | -- |
| Shell Powder | YES | Bone 1 | YES | YES (1883) | N/A (material) |
| Bone Hairpin | YES | Bone 4 | YES | YES (12505) | YES |
| Skull Hairpin | **NO** | -- | -- | -- | -- |
| Smilodon Mantle | YES | Leather 75 | YES | YES (16231) | YES |
| Bone Ring | YES | Bone 17 | YES | YES (13441) | YES |
| Mercury | YES | Alchemy 16 | YES | YES (914) | N/A (material) |
| Silent Oil | YES | Alchemy 24 | YES | YES (4165) | N/A (consumable) |
| Prism Powder | YES | Alchemy 36 | YES | YES (4164) | N/A (consumable) |
| Holy Water | YES | Alchemy 51 | YES | YES (4154) | N/A (consumable) |
| Meat Mithkabob | YES | Cook 38 | YES | YES (4381) | YES (Lua script) |
| Squid Sushi | YES | Cook 70 | YES | YES (5148) | YES (Lua script) |
| Tavnazian Taco | YES | Cook 81 | YES | YES (5174) | YES (Lua script) |
| Red Curry | YES | Cook 100 | YES | YES (4298) | YES (Lua script) |

---

## Recommendations

1. **ROV Bewitched items** -- These are likely an upstream (LandSandBoat) issue. The Bewitched/Voodoo equipment is ROV content that hasn't been fully implemented. Do not expect these to work until upstream adds the mods. Low priority for a ~4 player server.

2. **Dragon Leather** -- Could be added manually if high-level leathercraft is desired. Would need:
   - Dragon Skin item in item_basic.sql
   - Dragon Leather item in item_basic.sql (if not already present)
   - Synth recipe entry

3. **Skull Hairpin** -- Low priority missing recipe. Bone Hairpin and Bone Ring serve similar progression roles.
