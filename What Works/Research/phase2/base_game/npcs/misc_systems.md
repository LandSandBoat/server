# Miscellaneous Base Game Systems

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Signet, https://www.bg-wiki.com/ffxi/Sanction, https://www.bg-wiki.com/ffxi/Sigil, https://www.bg-wiki.com/ffxi/Ionis, https://www.bg-wiki.com/ffxi/Auction_House
- Codebase: scripts/globals/conquest.lua, scripts/effects/signet.lua, scripts/effects/sanction.lua, scripts/effects/sigil.lua, scripts/globals/besieged.lua, scripts/globals/campaign.lua, src/map/utils/auctionutils.cpp, src/map/linkshell.cpp, src/map/utils/charutils.cpp, src/map/entities/mobentity.cpp, src/map/conquest_system.cpp

## Summary
Nation buffs (Signet, Sanction, Sigil) all function with core mechanics working. Ionis exists but has no effect script (buff-less). Auction House is fully implemented in C++ but starts empty on a fresh server. Linkshells, Fame, Treasure Caskets, Nomad Moogles, and Goblin service NPCs all work.

---

## 1. Signet (Base Game Nation Buff)

| Item | Status | Notes |
|------|--------|-------|
| Obtain from gate guards | WORKS | `conquest.lua` line 1352-1357: option==1 grants SIGNET effect, duration based on player rank + nation rank |
| DEF/EVA bonus vs Even Match or lower | WORKS | `scripts/effects/signet.lua`: adds +15 DEF, +15 EVA via SIGNET_BONUS latent (latent activates only vs even match or lower targets per `latent_effect.h` line 45) |
| Crystal drops from mobs | WORKS | `src/map/entities/mobentity.cpp` lines 1094-1097: checks for EFFECT_SIGNET, rolls 20% chance per party member with signet in range |
| Conquest Points earned | WORKS | `src/map/utils/charutils.cpp` line 5533: awards CP at 10-15% of EXP earned while signet active in conquest regions |
| Influence points | WORKS | `conquest_system.cpp` line 667: influence added to player's nation based on CP earned |
| Small party EXP bonus | WORKS | `charutils.cpp` line 4839: `GetPlayerShareMultiplier` accounts for signet zone (reduces party size EXP penalty) |
| Increased healing HP while resting | PARTIAL | Mentioned in signet.lua comments but no mod for it in the effect script; likely handled in C++ core |
| No TP loss while resting | PARTIAL | Mentioned in signet.lua comments; likely handled in C++ core |
| Food duration bonus | MISSING | Not present in signet.lua (unlike sanction/sigil which explicitly add FOOD_DURATION mod) |
| Regional dominion effects | WORKS | `latent_effect_container.cpp` lines 1222-1244: NATION_CONTROL latent checks signet/sanction/sigil + region ownership for gear with regional bonuses |

### Signet Verdict: WORKS (core mechanics functional, food duration bonus missing from effect script)

---

## 2. Sanction (ToAU Nation Buff)

| Item | Status | Notes |
|------|--------|-------|
| Obtain from Salaheem's Sentinels | WORKS | `scripts/globals/besieged.lua` lines 197-219: sanction granted via besieged NPC event system |
| Requires mercenary rank | WORKS | Must have merc rank >= 1; cost is 100 imperial standing (free for basic sanction) |
| Regen option (power=1) | WORKS | `scripts/effects/sanction.lua` line 13: adds Regen via SANCTION_REGEN_BONUS latent at 95% HP threshold |
| Refresh option (power=2) | WORKS | `scripts/effects/sanction.lua` line 15: adds Refresh via SANCTION_REFRESH_BONUS latent at 75% HP threshold |
| Food duration option (power=3) | WORKS | `scripts/effects/sanction.lua` line 17: adds FOOD_DURATION +100 mod |
| Imperial Standing earned from EXP | WORKS | `charutils.cpp` line 5540-5543: awards 10% of EXP as imperial standing while sanction active in ToAU zones |
| Crystal drops in ToAU zones | WORKS | `mobentity.cpp` lines 1101-1104: checks EFFECT_SANCTION for crystal roll |
| Duration scales with merc rank | WORKS | `besieged.lua` line 166: 3h base + 20min per merc rank; halved without Astral Candescence |

### Sanction Verdict: WORKS

---

## 3. Sigil (WotG Nation Buff)

| Item | Status | Notes |
|------|--------|-------|
| Obtain from Campaign NPCs | WORKS | NPCs exist: `Miliart_TK.lua` (Sandy[S]), `Millard_IM.lua` (Bastok[S]), `Mindala-Andola_CC.lua` (Windy[S]) - all call `xi.campaign.sigilOnTrigger` |
| Regen option | WORKS | `scripts/effects/sigil.lua` line 12: adds Regen via SIGIL_REGEN_BONUS latent; TODO note says percentage should be based on controlled areas |
| Refresh option | WORKS | `scripts/effects/sigil.lua` line 16: adds Refresh via SIGIL_REFRESH_BONUS latent |
| Food duration option | WORKS | `scripts/effects/sigil.lua` line 20: adds FOOD_DURATION +100 mod |
| EXP loss reduction | MISSING | `scripts/effects/sigil.lua` line 24-25: commented out, "exp loss reduction not implemented" |
| Crystal drops in WotG zones | WORKS | `mobentity.cpp` lines 1108-1111: checks EFFECT_SIGIL for crystal roll |
| Allied Notes earned from EXP | MISSING | `charutils.cpp` lines 5528-5544: only signet (CP) and sanction (IS) earn currency from EXP. No equivalent code for sigil -> allied notes. Allied notes exist as currency (`campaign.lua` references them) but are only earned from campaign battles/ops, not from regular EXP |
| Campaign battles (to earn Allied Notes) | MISSING | Campaign battles are not implemented (known issue); sigil buffs still work independently |

### Sigil Verdict: PARTIAL (buffs work, but allied notes not earned passively from EXP; campaign battles missing)

---

## 4. Ionis (SoA Buff)

| Item | Status | Notes |
|------|--------|-------|
| Effect ID exists | WORKS | `scripts/enum/effect.lua` line 511: `IONIS = 512` |
| NPC to grant it | PARTIAL | Only Ruth in Western Adoulin grants it during quest "A Pioneer's Best (Imaginary) Friend" (`scripts/zones/Western_Adoulin/npcs/Ruth.lua`); no general-purpose Ionis NPC found |
| Effect script | MISSING | No `scripts/effects/ionis.lua` file exists; the buff has no actual stat effects when applied |
| Crystal drops in SoA zones | WORKS | `mobentity.cpp` lines 1115-1118: checks EFFECT_IONIS for crystal roll (works if you have the buff) |
| Zone type flag | WORKS | `zone.h`: IONIS zone type = 0x0040 defined |

### Ionis Verdict: STUB (effect enum exists, crystal drops coded, but no effect script = no stat buffs, and no dedicated NPC to grant it outside one quest)

---

## 5. Auction House

| Item | Status | Notes |
|------|--------|-------|
| Core AH implementation | WORKS | Full C++ implementation in `src/map/utils/auctionutils.cpp`: SellingItems, PurchasingItems, CancelSale, OpenListOfSales, ProofOfPurchase all implemented |
| List items for sale | WORKS | Insert into `auction_house` DB table, deducts fee from gil, removes item from inventory |
| Buy items | WORKS | SQL UPDATE matches lowest-priced listing <= bid price; item added to buyer inventory, gil deducted |
| Cancel listings | WORKS | Returns item to seller inventory, deletes from DB |
| AH fee system | WORKS | Configurable via settings: `AH_BASE_FEE_SINGLE=1`, `AH_BASE_FEE_STACKS=4`, `AH_TAX_RATE_SINGLE=1.0%`, `AH_TAX_RATE_STACKS=0.5%`, `AH_MAX_FEE=10000` |
| Listing limit | WORKS | `AH_LIST_LIMIT=7` (retail default) |
| Stock on fresh server | EMPTY | `sql/auction_house.sql` creates the table but inserts zero rows. Fresh server = completely empty AH |
| Price history | WORKS | DB stores completed sales; client can query history |
| AH items whitelist | EXISTS | `sql/auction_house_items.sql` defines which items can appear on AH |

### AH Verdict: WORKS (mechanically complete, but EMPTY on fresh server -- on a 4-player server this is effectively useless without seeding or an AH bot)

### Workaround
- NPC vendors (Sparks gear, RoE vendor, etc.) serve as primary item source
- Could manually INSERT items into `auction_house` table to seed stock
- Some private servers use AH bot modules; LSB has `ah_pagination` module reference in settings

---

## 6. Goblin/Service NPCs

| Item | Status | Notes |
|------|--------|-------|
| Goblin Stew (HP recovery) | WORKS | `scripts/items/bowl_of_goblin_stew.lua` exists; sold by Pawkrix in Lower Jeuno (`scripts/zones/Lower_Jeuno/npcs/Pawkrix.lua`) for 150,000 gil (GOBLIN_STEW_880) |
| Nomad Moogle (job change) | WORKS | Scripts in Selbina, Mhaura, Kazham, Norg, Rabao, Nashmau, Tavnazian Safehold; calls `player:sendMenu(xi.menuType.MOOGLE)` which opens the mog house menu for job change/storage |
| Mog House / Rent-a-Room | WORKS | Mog house NPCs exist in all 3 nations (`Moozo-Koozo` in Sandy, `Styi_Palneh` in Bastok, `Burute-Sorute` in Windurst). Rent-a-Room available via Waypoints in Adoulin (`scripts/globals/waypoint.lua` lines 34, 44) |
| Treasure Caskets | WORKS | 60+ zone-specific Treasure_Casket NPC scripts exist; global casket system at `scripts/globals/caskets.lua` handles drop tables, lock combos, and loot |
| Gobbiebag quests | WORKS | All 10 Gobbiebag quests exist (`scripts/quests/jeuno/The_Gobbiebag_Part_I.lua` through `Part_X.lua`) |

### Service NPCs Verdict: WORKS

---

## 7. Linkshell System

| Item | Status | Notes |
|------|--------|-------|
| Create linkshell | WORKS | `src/map/linkshell.cpp`: `RegisterNewLinkshell()` creates LS in DB, validates name uniqueness |
| Equip/join linkshell | WORKS | `AddOnlineMember()` loads LS from DB if not cached, adds player to member list |
| Chat in linkshell | WORKS | `PushPacket()` sends chat to all online members; supports LS1 and LS2 |
| Linkshell message | WORKS | `setMessage()` stores message in DB, broadcasts via IPC to all map servers |
| Promote/demote members | WORKS | `ChangeMemberRank()` handles pearl <-> pearlsack promotion |
| Kick members | WORKS | `RemoveMemberByName()` breaks pearls if kicked by shell holder |
| Break linkshell | WORKS | `BreakLinkshell()` removes all members, marks LS as broken in DB |
| Dual linkshell (LS1/LS2) | WORKS | Full support: separate slots SLOT_LINK1/SLOT_LINK2, separate DB columns |

### Linkshell Verdict: WORKS

---

## 8. Fame System

| Item | Status | Notes |
|------|--------|-------|
| Fame stored per area | WORKS | C++ `addFame()` in `lua_baseentity.cpp` line 7523 accepts fameArea + value; multiple fame areas supported |
| Fame increases from quests | WORKS | `scripts/globals/npc_util.lua` lines 589, 679: `completeQuest` and `giveItem` helpers call `player:addFame()` when quest params include `fameArea` and `fame` values |
| Fame affects shop prices | WORKS | `scripts/globals/shop.lua` line 28: price multiplier uses `player:getFameLevel()` -- higher fame = lower prices |
| getFame / getFameLevel | WORKS | Both functions implemented in C++ (`lua_baseentity.cpp` lines 7459, 7648); getFameLevel converts raw fame to 1-9 scale |
| Default fame per quest | WORKS | `npc_util.lua` line 676: if quest doesn't specify fame amount, defaults to 30 |
| Fame areas (Sandy/Bastok/Windy/Jeuno/Norg/etc.) | WORKS | Multiple fame areas supported including Adoulin (`xi.fameArea.ADOULIN`) |

### Fame Verdict: WORKS

---

## Blockers

| System | Blocker | Impact |
|--------|---------|--------|
| Signet | Food duration bonus missing from effect script | Minor: food already has base duration |
| Sigil | Allied Notes not earned from regular EXP (only from campaign, which is missing) | Medium: no way to earn Allied Notes without campaign battles |
| Ionis | No effect script, no dedicated NPC | Medium: buff gives no stats; only obtainable via one SoA quest |
| Auction House | Empty on fresh server | High for economy: 4-player server has no item circulation without manual seeding |

## Fix Difficulty

| System | Difficulty | Notes |
|--------|------------|-------|
| Signet food duration | Easy | Add `target:addMod(xi.mod.FOOD_DURATION, 100)` to signet.lua (matching sanction/sigil pattern) |
| Sigil Allied Notes | Medium | Add code block in `charutils.cpp` after sanction section to award allied_notes from EXP in WotG regions |
| Ionis effect script | Easy | Create `scripts/effects/ionis.lua` with stat buffs (retail: Regen, Refresh, food duration, etc.) |
| Ionis NPC | Medium | Need dedicated Ionis NPC in Eastern/Western Adoulin (Peacekeepers Coalition) |
| AH seeding | Easy | Insert items into `auction_house` table via SQL, or use an AH bot module |
| Campaign battles (for Allied Notes) | Massive | Full Campaign battle system is a major feature not yet implemented |
