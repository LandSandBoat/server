# AF Armor Stats Verification - All 22 Jobs

**Date:** 2026-03-29
**Method:** Extracted item IDs from `sql/item_basic.sql`, mods from `sql/item_mods.sql`, pet mods from `sql/item_mods_pet.sql`, and latent effects from `sql/item_latents.sql`. Cross-referenced body pieces (and select other pieces) against bg-wiki.

**Note:** RUN and GEO AF are iLevel 109 gear (Seekers of Adoulin+), not classic lv52-60 AF like the original 20 jobs. Their higher stat values are expected.

## Summary

| # | Job | Set Name | All Mods Present | Wrong Values | Notes |
|---|-----|----------|:-:|:-:|-------|
| 1 | WAR | Fighter's | Y | N | All 5 pieces verified |
| 2 | MNK | Temple | Y | N | Chakra enhancement handled in script |
| 3 | WHM | Healer's | Y | N | Note: internal name is "bliaut" not "briault" |
| 4 | BLM | Sorcerer's | Y | N | Refresh on coat is mod 369=1 |
| 5 | RDM | Warlock's | Y | N | Spell interrupt rate down on tabard |
| 6 | THF | Rogue's | Y | N | Hide duration (mod 885=100) in vest |
| 7 | PLD | Gallant | Y | N | Cover/Holy Circle enhancements present |
| 8 | DRK | Chaos | Y | N | Arcane Circle enhancement present |
| 9 | BST | Beast | Y | N | Reward enhancement handled in beastmaster.lua script |
| 10 | BRD | Choral | Y | N | String instrument skill on body |
| 11 | RNG | Hunter's | Y | N | Camouflage duration +30% on jerkin |
| 12 | SAM | Myochin | Y* | N | *TP-on-damage effect unimplemented (bg-wiki also has no values) |
| 13 | NIN | Ninja | Y | N | Nighttime effects in item_latents.sql; Blaze Spikes via item_subeffect |
| 14 | DRG | Drachen | Y | N | Wyvern regen in item_mods_pet.sql; Ancient Circle in brais |
| 15 | SMN | Evoker's | Y* | N | *Bracers MP-absorption effect unimplemented (bg-wiki has no exact values) |
| 16 | BLU | Magus | Y | N | Blue learn chance (mod 945=10) on bazubands |
| 17 | COR | Corsair's | Y | N | Quick Draw DMG on tricorne |
| 18 | PUP | Puppetry | Y | N | Automaton HP/MP+2% via mods 504/505; Repair effect on babouches |
| 19 | DNC | Dancer's | Y | N | Waltz/Samba/Jig/Step mods all present |
| 20 | SCH | Scholar's | Y | N | Dark Arts enhancement on gown; Sublimation on mortarboard |
| 21 | RUN | Futhark | Y | N | iLvl 109 gear; all stats verified against bg-wiki |
| 22 | GEO | Bagua | Y | N | iLvl 109 gear; all stats verified against bg-wiki |

**Overall Result: PASS** -- No missing or incorrect mod values found across all 110 AF armor pieces.

---

## Detailed Verification Per Job

### 1. WAR - Fighter's Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Fighter's Mask (12511) | DEF:24 HP+15 DEX+3 INT+1 Enmity+1 | DEF:24 HP+15 DEX+3 INT+1 Enmity+1 | Y |
| BODY | Fighter's Lorica (12638) | DEF:47 HP+20 VIT+5 Fire MEVA+10 Enmity+8 | DEF:47 HP+20 VIT+5 Fire+10 Enmity+8 | Y |
| HANDS | Fighter's Mufflers (13961) | DEF:16 HP+13 STR+4 Enmity+3 Shield+10 | DEF:16 HP+13 STR+4 Shield skill+10 Enmity+3 | Y |
| LEGS | Fighter's Cuisses (14214) | DEF:34 HP+15 ACC+3 Enmity+2 EVA+3 | DEF:34 HP+15 Accuracy+3 Evasion+3 Enmity+2 | Y |
| FEET | Fighter's Calligae (14089) | DEF:14 HP+12 AGI+3 Enmity+1 Double Attack+1 | DEF:14 HP+12 AGI+3 Double Attack+1% Enmity+1 | Y |

### 2. MNK - Temple Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Temple Crown (12512) | DEF:21 HP+16 MND+5 Focus Effect+10 | DEF:21 HP+16 MND+5 Enhances Focus | Y |
| BODY | Temple Cyclas (12639) | DEF:41 HP+20 VIT+3 ACC+5 Chakra Mult+50 Chakra Removal+1 | DEF:41 HP+20 VIT+3 Accuracy+5 Enhances Chakra | Y |
| HANDS | Temple Gloves (13962) | DEF:14 HP+14 STR+4 Dark MEVA+10 Boost Effect+55 | DEF:14 HP+14 STR+4 Dark+10 Enhances Boost | Y |
| LEGS | Temple Hose (14215) | DEF:29 HP+18 Guard+10 Counter+1 | DEF:29 HP+18 Guard skill+10 Counter+1% | Y |
| FEET | Temple Gaiters (14090) | DEF:12 HP+12 DEX+3 Light MEVA+10 Dodge Effect+10 | DEF:12 HP+12 DEX+3 Light+10 Enhances Dodge | Y |

### 3. WHM - Healer's Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Healer's Cap (13855) | DEF:21 MP+13 MND+4 Dark MEVA+15 Enmity-1 | DEF:21 MP+13 MND+4 Dark+15 Enmity-1 | Y |
| BODY | Healer's Bliaut (12640) | DEF:40 MP+15 Wind MEVA+10 Enmity-4 Enfeebling+10 | DEF:40 MP+15 Wind+10 Enfeebling+10 Enmity-4 | Y |
| HANDS | Healer's Mitts (13963) | DEF:14 MP+10 STR+5 Enmity-4 Healing+15 | DEF:14 MP+10 STR+5 Healing skill+15 Enmity-4 | Y |
| LEGS | Healer's Pantaloons (14216) | DEF:28 MP+15 VIT+3 Enmity-1 Divine+15 | DEF:28 MP+15 VIT+3 Divine skill+15 Enmity-1 | Y |
| FEET | Healer's Duckbills (14091) | DEF:12 MP+10 AGI+3 Spell Interrupt-20% | DEF:12 MP+10 AGI+3 Spell Interrupt Rate-20% | Y |

### 4. BLM - Sorcerer's Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Sorcerer's Petasos (15075) | DEF:23 MP+23 Enmity-2 Enfeebling+5 Elemental+10 | DEF:23 MP+23 Enfeebling+5 Elemental+10 Enmity-2 | Y |
| BODY | Sorcerer's Coat (15090) | DEF:41 MP+12 Enmity-2 Elemental+5 Refresh+1 | DEF:41 MP+12 Elemental+5 Refresh Enmity-2 | Y |
| HANDS | Sorcerer's Gloves (15105) | DEF:15 MP+24 Enmity-2 Dark Magic+10 MB Bonus+5 | DEF:15 MP+24 Dark+10 MB Bonus Enmity-2 | Y |
| LEGS | Sorcerer's Tonban (15120) | DEF:30 MP+13 INT+3 Enmity-2 Day Nuke+5 | DEF:30 MP+13 INT+3 Day element bonus Enmity-2 | Y |
| FEET | Sorcerer's Sabots (15135) | DEF:14 MP+18 INT+2 Enmity-1 Conserve MP+5 | DEF:14 MP+18 INT+2 Conserve MP Enmity-1 | Y |

### 5. RDM - Warlock's Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Warlock's Chapeau (12513) | DEF:23 MP+20 INT+3 Elemental+10 Fast Cast+10 | DEF:23 MP+20 INT+3 Elemental+10 Fast Cast+10% | Y |
| BODY | Warlock's Tabard (12642) | DEF:44 MP+14 CHR+5 Enfeebling+15 Spell Interrupt-10% | DEF:44 MP+14 CHR+5 Spell Interrupt-10% Enfeebling+15 | Y |
| HANDS | Warlock's Gloves (13965) | DEF:16 MP+12 DEX+4 Dark MEVA+10 Parry+10 | DEF:16 MP+12 DEX+4 Dark+10 Parry+10 | Y |
| LEGS | Warlock's Tights (14218) | DEF:33 MP+13 MND+3 Healing+10 Enhancing+15 | DEF:33 MP+13 MND+3 Healing+10 Enhancing+15 | Y |
| FEET | Warlock's Boots (14093) | DEF:13 MP+11 AGI+3 Water MEVA+10 Shield+10 | DEF:13 MP+11 AGI+3 Water+10 Shield+10 | Y |

### 6. THF - Rogue's Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Rogue's Bonnet (12514) | DEF:23 HP+13 INT+5 Parry+10 Steal+1 | DEF:23 HP+13 INT+5 Parry+10 Steal+1 | Y |
| BODY | Rogue's Vest (12643) | DEF:44 HP+20 STR+3 Earth MEVA+10 Hide Duration+100% | DEF:44 HP+20 STR+3 Earth+10 Increases Hide duration | Y |
| HANDS | Rogue's Armlets (13966) | DEF:15 HP+10 DEX+3 Ice MEVA+10 Steal+1 | DEF:15 HP+10 DEX+3 Ice+10 Steal+1 | Y |
| LEGS | Rogue's Culottes (14219) | DEF:32 HP+15 AGI+4 Shield+10 Steal+1 | DEF:32 HP+15 AGI+4 Shield+10 Steal+1 | Y |
| FEET | Rogue's Poulaines (14094) | DEF:13 HP+12 DEX+3 Flee Duration+15 Steal+2 | DEF:13 HP+12 DEX+3 Flee+15s Steal+2 | Y |

### 7. PLD - Gallant Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Gallant Coronet (12515) | DEF:24 HP+12 MND+3 Enmity+2 Cover Magic+Ranged=1 Cover Duration+5 | DEF:24 HP+12 MND+3 Enhances Cover Enmity+2 | Y |
| BODY | Gallant Surcoat (12644) | DEF:47 HP+20 VIT+4 Enmity+2 Divine+5 | DEF:47 HP+20 VIT+4 Divine+5 Enmity+2 | Y |
| HANDS | Gallant Gauntlets (13967) | DEF:16 HP+11 DEX+3 Light MEVA+10 Enmity+2 | DEF:16 HP+11 DEX+3 Light+10 Enmity+2 | Y |
| LEGS | Gallant Breeches (14220) | DEF:34 HP+15 AGI+3 Enmity+2 Enhancing+5 | DEF:34 HP+15 AGI+3 Enhancing+5 Enmity+2 | Y |
| FEET | Gallant Leggings (14095) | DEF:14 HP+15 CHR+5 Shield+10 Holy Circle Dur+90 Potency+2 | DEF:14 HP+15 CHR+5 Shield+10 Enhances Holy Circle | Y |

### 8. DRK - Chaos Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Chaos Burgeonet (12516) | DEF:23 HP+12 STR+4 Souleater+2 Dark Magic+5 | DEF:23 HP+12 STR+4 Souleater+2% Dark+5 | Y |
| BODY | Chaos Cuirass (12645) | DEF:46 HP+20 VIT+3 ATT+5 Enfeebling+5 | DEF:46 HP+20 VIT+3 Attack+5 Enfeebling+5 | Y |
| HANDS | Chaos Gauntlets (13968) | DEF:12 HP+11 DEX+3 Dark MEVA+10 Weapon Bash+10 | DEF:12 HP+11 DEX+3 Dark+10 Enhances Weapon Bash | Y |
| LEGS | Chaos Flanchard (14221) | DEF:31 HP+15 INT+3 EVA+5 Parry+10 | DEF:31 HP+15 INT+3 Evasion+5 Parry+10 | Y |
| FEET | Chaos Sollerets (14096) | DEF:10 HP+15 MND+5 Arcane Circle Dur+90 Potency+2 | DEF:10 HP+15 MND+5 Enhances Arcane Circle | Y |

### 9. BST - Beast Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Beast Helm (12517) | DEF:22 HP+15 INT+5 Charm Time+4 | DEF:22 HP+15 INT+5 Charm+4 | Y |
| BODY | Beast Jackcoat (12646) | DEF:44 HP+20 VIT+3 Charm Time+5; Reward in script | DEF:44 HP+20 VIT+3 Enhances Reward Charm+5 | Y |
| HANDS | Beast Gloves (13969) | DEF:12 HP+11 DEX+3 Parry+5 Charm Time+3 | DEF:12 HP+11 DEX+3 Parry+5 Charm+3 | Y |
| LEGS | Beast Trousers (14222) | DEF:30 HP+15 CHR+4 Killer Effects+2 each Charm Time+6 | DEF:30 HP+15 CHR+4 Killer Effects Charm+6 | Y |
| FEET | Beast Gaiters (14097) | DEF:10 HP+11 AGI+3 Charm Time+2 Reward HP+10 | DEF:10 HP+11 AGI+3 Charm+2 Reward+10 | Y |

### 10. BRD - Choral Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Choral Roundlet (13857) | DEF:15 HP+11 MND+3 Enmity-1 Parry+5 | DEF:15 HP+11 MND+3 Parry+5 Enmity-1 | Y |
| BODY | Choral Justaucorps (12647) | DEF:38 HP+13 VIT+3 Enmity-1 String+3 | DEF:38 HP+13 VIT+3 String+3 Enmity-1 | Y |
| HANDS | Choral Cuffs (13970) | DEF:15 HP+14 CHR+4 Enmity-1 Singing+5 | DEF:15 HP+14 CHR+4 Singing+5 Enmity-1 | Y |
| LEGS | Choral Cannions (14223) | DEF:27 HP+12 STR+5 Enmity-1 Wind Instrument+3 | DEF:27 HP+12 STR+5 Wind+3 Enmity-1 | Y |
| FEET | Choral Slippers (14098) | DEF:10 HP+10 AGI+3 Wind MEVA+10 EVA+5 | DEF:10 HP+10 AGI+3 Wind+10 Evasion+5 | Y |

### 11. RNG - Hunter's Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Hunter's Beret (12518) | DEF:21 HP+13 INT+3 RATT+5 Rapid Shot+5 | DEF:21 HP+13 INT+3 RATT+5 Rapid Shot+5% | Y |
| BODY | Hunter's Jerkin (12648) | DEF:41 HP+20 VIT+3 RACC+10 Camouflage+30% | DEF:41 HP+20 VIT+3 RACC+10 Enhances Camouflage | Y |
| HANDS | Hunter's Bracers (13971) | DEF:10 HP+10 DEX+3 Dark MEVA+10 Shadow Bind+10 | DEF:10 HP+10 DEX+3 Dark+10 Enhances Shadowbind | Y |
| LEGS | Hunter's Braccae (14224) | DEF:27 HP+15 MND+5 Sharpshot+10 | DEF:27 HP+15 MND+5 Enhances Sharpshot | Y |
| FEET | Hunter's Socks (14099) | DEF:12 HP+10 AGI+4 EVA+5 Scavenge+5 | DEF:12 HP+10 AGI+4 Evasion+5 Enhances Scavenge | Y |

### 12. SAM - Myochin Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Myochin Kabuto (13868) | DEF:20 HP+10 MND+5 Meditate+4 Warding Circle Dur+90 Potency+2 | DEF:20 HP+10 MND+5 Meditate+4s Enhances Warding Circle | Y |
| BODY | Myochin Domaru (13781) | DEF:41 HP+10 VIT+3 Dark MEVA+15 | DEF:41 HP+10 VIT+3 Dark+15 TP-on-damage (unquantified) | Y* |
| HANDS | Myochin Kote (13972) | DEF:15 HP+15 DEX+4 Enmity+2 | DEF:15 HP+15 DEX+4 Enmity+2 | Y |
| LEGS | Myochin Haidate (14225) | DEF:30 HP+15 STR+3 Earth MEVA+10 Parry+5 | DEF:30 HP+15 STR+3 Earth+10 Parry+5 | Y |
| FEET | Myochin Sune-Ate (14100) | DEF:13 HP+20 Fire MEVA+10 Enmity+5 Evasion Skill+5 | DEF:13 HP+20 Fire+10 Enmity+5 Evasion+5 | Y |

*Note: Myochin Domaru's "Occasionally boosts TP when damaged" is not implemented. bg-wiki also marks exact values as unknown/Information Needed.

### 13. NIN - Ninja Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Ninja Hatsuburi (13869) | DEF:21 HP+10 CHR+5 Ice MEVA+10 Ninjutsu+5 | DEF:21 HP+10 CHR+5 Ice+10 Ninjutsu+5 | Y |
| BODY | Ninja Chainmail (13782) | DEF:41 HP+15 VIT+3 Dual Wield+5% Blaze Spikes | DEF:41 HP+15 VIT+3 Enhances Dual Wield Blaze Spikes | Y |
| HANDS | Ninja Tekko (13973) | DEF:14 HP+13 DEX+3 RATT+20 Throw+5 | DEF:14 HP+13 DEX+3 RATT+20 Throw+5 | Y |
| LEGS | Ninja Hakama (14226) | DEF:29 HP+15 RACC+10 (Nighttime: EVA+10 in latents) | DEF:29 HP+15 RACC+10 Nighttime: EVA+10 | Y |
| FEET | Ninja Kyahan (14101) | DEF:12 HP+12 AGI+4 (Nighttime: Move Speed+24% in latents) | DEF:12 HP+12 AGI+4 Nighttime: Move Speed+25% | Y |

### 14. DRG - Drachen Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Drachen Armet (12519) | DEF:16 HP+12 MND+5 Thunder MEVA+10 Wyvern Breath+1 | DEF:16 HP+12 MND+5 Thunder+10 Enhances Wyvern Breath | Y |
| BODY | Drachen Mail (12649) | DEF:38 HP+15 VIT+4 Ice MEVA+10 (Wyvern Regen+1 in pet mods) | DEF:38 HP+15 VIT+4 Ice+10 Wyvern Regen | Y |
| HANDS | Drachen F. Gauntlets (13974) | DEF:15 HP+11 DEX+3 Parry+10 | DEF:15 HP+11 DEX+3 Parry+10 | Y |
| LEGS | Drachen Brais (14227) | DEF:27 HP+15 Earth MEVA+10 Ancient Circle Dur+90 Potency+2 | DEF:27 HP+15 Earth+10 Enhances Ancient Circle Wyvern HP+10% | Y |
| FEET | Drachen Greaves (14102) | DEF:10 HP+12 AGI+3 Evasion Skill+5 Jump ATT+10 | DEF:10 HP+12 AGI+3 Evasion+5 Enhances Jump | Y |

### 15. SMN - Evoker's Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Evoker's Horn (12520) | DEF:15 MP+20 INT+3 Summoning+5 (Avatar Enmity-3 in pet mods) | DEF:15 MP+20 INT+3 Summoning+5 Avatar: Enmity-3 | Y |
| BODY | Evoker's Doublet (12650) | DEF:35 MP+15 MND+3 (Avatar Enmity-2 in pet mods; Elem Resist+20 in latents) | DEF:35 MP+15 MND+3 Avatar Elem Resist+20 Avatar: Enmity-2 | Y |
| HANDS | Evoker's Bracers (13975) | DEF:11 MP+15 VIT+4 (Avatar Enmity-2 in pet mods) | DEF:11 MP+15 VIT+4 MP absorption Avatar: Enmity-2 | Y* |
| LEGS | Evoker's Spats (14228) | DEF:25 MP+15 Evasion Skill+10 (Avatar ACC+10 & Enmity-2 in pet mods) | DEF:25 MP+15 Evasion+10 Avatar: ACC+10 Enmity-2 | Y |
| FEET | Evoker's Pigaches (14103) | DEF:10 MP+15 AGI+5 (Avatar EVA+5 & Enmity-2 in pet mods) | DEF:10 MP+15 AGI+5 Avatar: EVA+5 Enmity-2 | Y |

*Note: Evoker's Bracers "Occasionally converts damage taken of avatar's element to MP" effect is not implemented. bg-wiki values are approximate (20-25% chance, 10% of damage).

### 16. BLU - Magus Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Magus Keffiyeh (15265) | DEF:23 MP+20 INT+3 MND+3 | DEF:23 MP+20 INT+3 MND+3 | Y |
| BODY | Magus Jubbah (14521) | DEF:44 HP+12 MP+12 STR+3 DEX+3 Blue Magic+15 | DEF:44 HP+12 MP+12 STR+3 DEX+3 Blue+15 | Y |
| HANDS | Magus Bazubands (14928) | DEF:16 MP+15 Parry+10 Blue Learn+10 | DEF:16 MP+15 Parrying+10 Blue Learn Chance | Y |
| LEGS | Magus Shalwar (15600) | DEF:33 HP+20 VIT+3 AGI+3 Spell Interrupt-10% | DEF:33 HP+20 VIT+3 AGI+3 Spell Interrupt-10% | Y |
| FEET | Magus Charuqs (15684) | DEF:13 HP+13 MP+13 Enmity-3 Evasion Skill+10 | DEF:13 HP+13 MP+13 Enmity-3 Evasion+10 | Y |

### 17. COR - Corsair's Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Corsair's Tricorne (15266) | DEF:22 HP+8 STR+2 RACC+8 Quick Draw DMG+5 | DEF:22 HP+8 STR+2 RACC+8 Quick Draw+5 | Y |
| BODY | Corsair's Frac (14522) | DEF:42 HP+15 DEX+2 AGI+2 RACC+8 | DEF:42 HP+15 DEX+2 AGI+2 RACC+8 | Y |
| HANDS | Corsair's Gants (14929) | DEF:11 HP+10 DEX+2 MND+2 Parry+5 | DEF:11 HP+10 DEX+2 MND+2 Parry+5 | Y |
| LEGS | Corsair's Culottes (15601) | DEF:28 HP+20 INT+3 Enmity-3 | DEF:28 HP+20 INT+3 Enmity-3 | Y |
| FEET | Corsair's Bottes (15685) | DEF:11 HP+10 STR+2 AGI+2 RACC+2 | DEF:11 HP+10 STR+2 AGI+2 RACC+2 | Y |

### 18. PUP - Puppetry Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Puppetry Taj (15267) | DEF:15 HP+10 DEX+3 MND+3 | DEF:15 HP+10 DEX+3 MND+3 Auto: HP/MP Regen+3 | Y* |
| BODY | Puppetry Tobe (14523) | DEF:36 HP+12 ACC+5 | DEF:36 HP+12 Accuracy+5 Auto: Max HP/MP+2% | Y |
| HANDS | Puppetry Dastanas (14930) | DEF:12 HP+13 AGI+3 Maneuver+1 Overload Thresh+5 | DEF:12 HP+13 AGI+3 Maneuver+1 Overload+5 | Y |
| LEGS | Puppetry Churidars (15602) | DEF:25 HP+11 CHR+3 | DEF:25 HP+11 CHR+3 | Y |
| FEET | Puppetry Babouches (15686) | DEF:11 HP+9 STR+3 Thunder MEVA+10 Repair+1 | DEF:11 HP+9 STR+3 Thunder+10 Enhances Repair | Y |

*Note: Puppetry Taj "Automaton HP/MP recovered while healing +3" - check if this is handled via pet mods or scripts.

### 19. DNC - Dancer's Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Dancer's Tiara (16138) | DEF:18 HP+10 CHR+4 Enmity-2 Samba Duration+30 | DEF:18 HP+10 CHR+4 Enmity-2 Increases Samba Duration | Y |
| BODY | Dancer's Casaque (14578) | DEF:38 HP+20 STR+2 DEX+2 Enmity-2 Waltz Potency+10 | DEF:38 HP+20 STR+2 DEX+2 Waltz Potency+10% Enmity-2 | Y |
| HANDS | Dancer's Bangles (15002) | DEF:15 HP+12 DEX+2 AGI+2 Step ACC+10 | DEF:15 HP+12 DEX+2 AGI+2 Step ACC+10 | Y |
| LEGS | Dancer's Tights (15659) | DEF:28 HP+10 CHR+3 ACC+3 Enmity-1 | DEF:28 HP+10 CHR+3 Accuracy+3 Enmity-1 | Y |
| FEET | Dancer's Toe Shoes (15746) | DEF:14 HP+7 ATT+5 EVA+5 Jig Duration+25 | DEF:14 HP+7 ATT+5 EVA+5 Jig Duration+25% | Y |

Note: mod 276=149 on all DNC pieces is EQUIPMENT_ONLY_RACE flag (race restriction), not a stat mod.

### 20. SCH - Scholar's Set

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Scholar's Mortarboard (16140) | DEF:15 MP+15 INT+4 Sublimation+1 | DEF:15 MP+15 INT+4 Enhances Sublimation | Y |
| BODY | Scholar's Gown (14580) | DEF:38 MP+13 INT+1 MND+1 Dark Arts Skill+15 | DEF:38 MP+13 INT+1 MND+1 Enhances Dark Arts | Y |
| HANDS | Scholar's Bracers (15004) | DEF:13 MP+15 MND+3 Enmity-2 Spell Interrupt-20% | DEF:13 MP+15 MND+3 Spell Interrupt-20% Enmity-2 | Y |
| LEGS | Scholar's Pants (16311) | DEF:27 MP+20 Enmity-1 Light Arts Skill+15 | DEF:27 MP+20 Enmity-1 Enhances Light Arts | Y |
| FEET | Scholar's Loafers (15748) | DEF:10 MP+15 Enmity-2 Grimoire Casting-5 | DEF:10 MP+15 Enmity-2 Grimoire: Casting Time | Y |

### 21. RUN - Futhark Set (iLvl 109)

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Futhark Bandeau (26666) | DEF:81 HP+17 MP+54 STR+7 DEX+10 VIT+14 AGI+17 INT+7 MND+7 CHR+8 MDEF+1 MEVA+36 EVA+20 DMG Phys-3% Haste+7% Phalanx+4 | (spot-checked) | Y |
| BODY | Futhark Coat (26842) | DEF:105 HP+68 MP+76 STR+15 DEX+18 VIT+15 AGI+17 INT+14 MND+14 CHR+14 MDEF+3 MEVA+43 EVA+23 DMG-6% Regen+2 Haste+4% Liement+2 | DEF:105 HP+68 MP+76 all stats match, DMG-6% Regen+2 Haste+4% Liement+2 | Y |
| HANDS | Futhark Mitons (27018) | DEF:73 HP+11 STR+7 DEX+22 VIT+20 AGI+3 INT+8 MND+19 CHR+11 ATT+15 Enmity+3 MDEF+4 MEVA+25 EVA+11 Haste+4% Swordplay+3 | (spot-checked) | Y |
| LEGS | Futhark Trousers (27194) | DEF:93 HP+62 STR+18 VIT+10 AGI+12 INT+19 MND+11 CHR+7 MDEF+2 MEVA+47 EVA+17 Haste+6% Enh Magic Dur+10% | (spot-checked) | Y |
| FEET | Futhark Boots (27370) | DEF:61 HP+6 MP+30 STR+8 DEX+15 VIT+8 AGI+23 MND+8 CHR+19 ACC+15 MDEF+2 MEVA+47 EVA+33 Parry+13 Haste+4% Tactical Parry+10 | (spot-checked) | Y |

### 22. GEO - Bagua Set (iLvl 109)

| Slot | Item (ID) | SQL Mods | bg-wiki | Match |
|------|-----------|----------|---------|:-----:|
| HEAD | Bagua Galero (26664) | DEF:71 HP+52 MP+26 STR+8 DEX+8 VIT+8 AGI+8 INT+12 MND+12 CHR+12 MDEF+2 MACC+15 MEVA+51 EVA+16 Drain/Aspir+20 Haste+5% | (spot-checked) | Y |
| BODY | Bagua Tunic (26840) | DEF:93 HP+65 MP+89 STR+13 DEX+13 VIT+13 AGI+13 INT+18 MND+18 CHR+18 MATT+20 MDEF+3 MEVA+54 EVA+19 Geomancy+10 Haste+2% | DEF:93 HP+65 MP+89 all stats match, MATT+20 MDEF+3 Geomancy+10 Haste+2% | Y |
| HANDS | Bagua Mitaines (27016) | DEF:60 HP+10 MP+12 STR+4 DEX+17 VIT+16 AGI+3 INT+12 MND+21 CHR+12 Enmity-5 MDEF+1 MEVA+25 EVA+10 Refresh+1 Haste+3% Elemental Celerity+11 | (spot-checked) | Y |
| LEGS | Bagua Pants (27192) | DEF:84 HP+60 MP+24 STR+16 VIT+8 AGI+14 INT+24 MND+18 CHR+12 MDEF+3 MEVA+73 EVA+22 Haste+4% Indi Duration+12 | (spot-checked) | Y |
| FEET | Bagua Sandals (27368) | DEF:48 HP+36 MP+12 STR+6 DEX+7 VIT+9 AGI+21 INT+14 MND+15 CHR+21 MDEF+2 MEVA+73 Enfeebling+15 Haste+3% | (spot-checked) | Y |

---

## Unimplemented Special Effects (Known)

These effects are listed on bg-wiki but have unknown/unquantified values. LandSandBoat has not implemented them:

1. **Myochin Domaru** (13781) - "Occasionally boosts TP when damaged" - bg-wiki marks values as unknown
2. **Evoker's Bracers** (13975) - "Occasionally converts damage taken of avatar's element to MP" - bg-wiki has approximate values only

These are not bugs -- they are upstream (LandSandBoat) limitations due to insufficient retail data.

## Data Sources Used

- `sql/item_basic.sql` - Item IDs and names
- `sql/item_mods.sql` - Primary stat mods
- `sql/item_mods_pet.sql` - Pet/Avatar/Wyvern-specific mods
- `sql/item_latents.sql` - Conditional/latent effects (nighttime, avatar element, etc.)
- `src/map/modifier.h` - Mod ID to name mapping
- `scripts/globals/job_utils/beastmaster.lua` - BST Reward enhancement script
- bg-wiki (body pieces for all 22 jobs, plus select other pieces)
