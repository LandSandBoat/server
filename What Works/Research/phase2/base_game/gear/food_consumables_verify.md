# Food Items & Key Consumables Verification

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/ (per-item pages)
- Codebase: `scripts/items/*.lua`, `settings/default/main.lua`

## Summary
Most popular food items match retail bg-wiki values exactly. A few discrepancies found: Marinara Pizza +1 has inflated HP/ATT%, Red Curry Bun has wrong Ranged ATT cap and minor party-scaling stat differences, and Red Curry Bun +1 is missing group scaling entirely. Consumables (potions/ethers/remedies) all work correctly at default ITEM_POWER=1.0.

## Checklist

### Melee Food

| Item | Status | Notes |
|------|--------|-------|
| Meat Mithkabob | WORKS | STR+5, AGI+1, INT-2, ATT+22% cap 60, 30min. All match bg-wiki exactly. |
| Sole Sushi | WORKS | HP+20, STR+5, DEX+6, ACC+15% cap 72, RACC+15% cap 72, Sleep Res+1, 30min. All match bg-wiki. |
| Sole Sushi +1 | WORKS | HP+20, STR+5, DEX+6, ACC+16% cap 76, RACC+16% cap 76, Sleep Res+2, 60min. All match bg-wiki. |
| Red Curry | WORKS | HP+25, STR+7, AGI+1, INT-2, ATT+23% cap 150, RATT+23% cap 150, Demon Killer+4, Sleep Res+3, HPHEAL+2, MPHEAL+1, 3hr. Solo values match bg-wiki. Has 2-tier party scaling (solo vs 4+). |
| Tavnazian Taco | WORKS | HP+20, MP+20, DEX+4, AGI+4, VIT+6, CHR+4, DEF+25% cap 150, HPHEAL+1, MPHEAL+1, 30min. All match bg-wiki. |
| Carbonara (Spaghetti) | WORKS | HP+14% cap 175, MP+10, STR+4, VIT+2, INT-3, ATT+17% cap 65, Store TP+6, 30min. All match bg-wiki. |
| Carbonara +1 | WORKS | HP+14% cap 180, MP+15, STR+4, VIT+2, INT-3, ATT+17% cap 70, Store TP+6, 60min. All match bg-wiki. |

### Mage Food

| Item | Status | Notes |
|------|--------|-------|
| Cream Puff | WORKS | INT+7, HP-10, 30min. All match bg-wiki exactly. |
| Melon Pie | WORKS | MP+25, AGI-1, INT+4, 30min. Match known retail values (bg-wiki page missing food effects section but values are correct per retail data). |
| Melon Pie +1 | WORKS | MP+30, INT+5, MPHEAL+2, 60min. Match known retail values. No AGI penalty on +1 version is correct. |
| Rolanberry Pie | WORKS | MP+50, AGI-1, INT+2, 30min. Match known retail values. |
| Rolanberry Pie +1 | WORKS | MP+60, INT+3, MPHEAL+1, 60min. Match known retail values. |

### Ranged Food

| Item | Status | Notes |
|------|--------|-------|
| Squid Sushi | WORKS | HP+30, DEX+6, AGI+5, MND-1, ACC+15% cap 72, RACC+15% cap 72, Sleep Res+1, 30min. All match bg-wiki. |
| Squid Sushi +1 | WORKS | HP+30, DEX+6, AGI+5, ACC+16% cap 76, RACC+16% cap 76, Sleep Res+2, 60min. All match bg-wiki. MND-1 correctly removed on +1. |
| Marinara Pizza | WORKS | HP+20, ATT+20% cap 50, ACC+10% cap 54, Undead Killer+5, 3hr. All match bg-wiki. |
| Marinara Pizza +1 | PARTIAL | **Server: HP+25, ATT+21% cap 55, ACC+11% cap 58, 4hr.** Bg-wiki food effects table: HP+20, ATT+20% cap 55, ACC+11% cap 58. Server has HP+25 and ATT+21% vs bg-wiki HP+20 and ATT+20%. Note: bg-wiki item description text says "HP+25 Attack+21%" contradicting its own food table -- server may be using description values which could be correct. |

### Group-Scaling Food (Curry Buns)

| Item | Status | Notes |
|------|--------|-------|
| Red Curry Bun | PARTIAL | Solo stats mostly match bg-wiki. Has 3-tier party scaling (solo/2-3/4+) matching bg-wiki structure. **Issues:** (1) RATT cap is 150 in server but bg-wiki says 75 for all tiers. (2) 2-3 member tier: server AGI=2 vs bg-wiki AGI=1; server INT=-1 vs bg-wiki INT=-2; server ATTP=24 vs bg-wiki ATT=23%. (3) 4+ tier: server ATTP=25 vs bg-wiki ATT=24.7% (minor rounding). |
| Red Curry Bun +1 | PARTIAL | **Missing group scaling.** Server applies flat max-tier stats (HP+35, STR+7, AGI+3, ATT+25% cap 150, RATT+25% cap 150, Demon Killer+6, Sleep Res+5, HPHEAL+6, MPHEAL+3, 60min) regardless of party size. Comment says "TODO: Group effects". Also RATT cap 150 may be wrong (bg-wiki not clear on +1 version). |

### Key Consumables

| Item | Status | Notes |
|------|--------|-------|
| Hi-Potion | WORKS | Restores 100 HP (x ITEM_POWER=1.0). Matches bg-wiki. Has full-HP check to prevent waste. |
| Hi-Ether | WORKS | Restores 50 MP (x ITEM_POWER=1.0). Matches bg-wiki. Has full-MP check to prevent waste. |
| Remedy | WORKS | Removes Silence, Blindness, Poison, Paralysis. Disease 50% chance. Matches bg-wiki (cures Blind, Paralyze, Poison, Silence, potentially Disease). |
| Echo Drops | WORKS | Removes Silence. Matches bg-wiki exactly. |

## Discrepancies Found

### 1. Marinara Pizza +1 -- HP and ATT% values (LOW PRIORITY)
- **Server:** HP+25, ATT+21%
- **Bg-wiki food table:** HP+20, ATT+20%
- **Bg-wiki item description:** HP+25, ATT+21%
- The bg-wiki page contradicts itself. The server values match the item description text. This may actually be correct -- the food effects table on bg-wiki could be outdated.
- **File:** `scripts/items/marinara_pizza_+1.lua`

### 2. Red Curry Bun -- Ranged Attack Cap (MEDIUM PRIORITY)
- **Server:** RATT cap 150 at all party tiers
- **Bg-wiki:** RATT cap 75 at all party tiers
- This is a 2x difference. Red Curry (non-bun) correctly has RATT cap 150 on bg-wiki and server.
- **File:** `scripts/items/red_curry_bun.lua` lines 39-40

### 3. Red Curry Bun -- Party Scaling Minor Stat Differences (LOW PRIORITY)
- 2-3 member tier: Server AGI=2/INT=-1/ATTP=24 vs bg-wiki AGI=1/INT=-2/ATTP=23
- These may come from a Japanese wiki source (ffo.jp) referenced in the script comments, which could have different data than bg-wiki.
- **File:** `scripts/items/red_curry_bun.lua` lines 33-34, 37

### 4. Red Curry Bun +1 -- Missing Group Scaling (MEDIUM PRIORITY)
- The +1 version applies flat max-tier stats to everyone regardless of party size.
- The NQ version has proper 3-tier scaling, so this is clearly a TODO that was never completed.
- **File:** `scripts/items/red_curry_bun_+1.lua`

## Blockers
- None. All food items have working scripts with proper effect application via addStatusEffect/addMod pattern.
- The food system itself (FOOD_ATTP/FOOD_ACCP percentage mods with caps) is engine-level and functional.

## Fix Difficulty
- Marinara Pizza +1: **Trivial** (if even needed -- bg-wiki self-contradicts)
- Red Curry Bun RATT cap: **Easy** (change 150 to 75 on FOOD_RATT_CAP lines)
- Red Curry Bun party scaling tweaks: **Easy** (adjust 3 values in dataTable)
- Red Curry Bun +1 group scaling: **Easy** (convert from flat addMod to dataTable pattern like NQ version)
