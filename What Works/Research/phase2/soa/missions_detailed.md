# Seekers of Adoulin -- Missions (Phase 2 Deep Audit)

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Seekers_of_Adoulin_Missions
- Codebase:
  - `scripts/missions/soa/` -- 106 files (105 mission scripts + helpers.lua)
  - `scripts/missions/soa/helpers.lua` -- imprimaturGate function + Teodor minigame
  - `scripts/zones/Rala_Waterways_U/instances/behind_the_sluices.lua` -- only instance file
  - `settings/default/main.lua` -- ENABLE_SOA = 1

## Summary
SoA has 105 mission scripts covering all ~110 retail missions across 5 chapters. Script count matches the wiki list almost exactly. However, the entire storyline is **BLOCKED at mission 1-6** due to the broken `imprimaturGate()` function in helpers.lua, which hardcodes `imprimatursSpent = 0` and never pulls from the DB. Additionally, most battlefield/instance fights beyond 2-7-1 have no instance implementation -- the mission scripts reference `_U` zone events that do not exist. Even if the gate were fixed, players would get stuck at multiple BCNM missions in chapters 3-5.

## How SoA Starts (Critical Path Entry)

| Step | Mission | What Happens | Status |
|------|---------|-------------|--------|
| 1 | 1-1: Rumors from the West | Talk to Darcia in Lower Jeuno. Get Geomagnetron KI (free) or pay 1M gil to skip to 1-3 | WORKS |
| 2 | 1-2: The Geomagnetron | Talk to Darcia again with Geomagnetron KI, get Adoulinian Charter Permit | WORKS |
| 3 | 1-3: Onward to Adoulin | Use Waypoint in Lower Jeuno, arrive in Ceizak Battlegrounds | WORKS |
| 4 | 1-4: Heartwings and the Kindhearted | Zone into Western Adoulin for cutscene | WORKS |
| 5 | 1-5: Pioneer Registration | Talk to Brenton in Western Adoulin. Get Pioneer's Badge, Map of Adoulin, 1000 bayld | WORKS |
| 6 | **1-6: Life on the Frontier** | Talk to Brenton -- **BLOCKED by imprimaturGate(player, 10)** | **BLOCKED** |

## The imprimaturGate Blocker (CRITICAL)

File: `scripts/missions/soa/helpers.lua` lines 8-14

```lua
xi.soa.helpers.imprimaturGate = function(player, gateAmount)
    -- TODO: All of this
    local imprimatursSpent = 0 -- TODO: Pull from DB
    local fame = player:getFameLevel(xi.fameArea.ADOULIN)
    local gate = 100 - (fame * gateAmount)
    return imprimatursSpent >= gate
end
```

The function calculates `gate = 100 - (fame * gateAmount)` and checks `imprimatursSpent >= gate`. Since `imprimatursSpent` is hardcoded to 0, the only way to pass is if `gate <= 0`, meaning `fame * gateAmount >= 100`.

| Mission | gateAmount | Fame needed for gate <= 0 | Result |
|---------|-----------|--------------------------|--------|
| 1-6: Life on the Frontier | 10 | fame >= 10 (max is 9) | **NEVER PASSES** |
| 1-8: Arciela Appears Again | 20 | fame >= 5 | Passes at fame 5+ |
| 2-7-3: Yggdrasil | 30 | fame >= 4 | Passes at fame 4+ |

Mission 1-6 is impossible to complete even at maximum fame level. Since every subsequent mission depends on 1-6 completing first, **the entire SoA storyline is blocked at mission 1-6**.

### Workaround
A GM can skip past mission 1-6 with: `!addmission 12 8` (sets player to mission 1-7).

### Fix
Replace the broken gate with `return true` or implement actual imprimatur tracking from the coalitions DB. The simplest fix:
```lua
xi.soa.helpers.imprimaturGate = function(player, gateAmount)
    return true -- Coalitions not implemented; always pass gate
end
```

## Script Count vs Wiki

| Chapter | Wiki Count | Script Count | Match? |
|---------|-----------|-------------|--------|
| Chapter 1: The Sacred City of Adoulin | 8 | 8 | YES |
| Chapter 2: The Ancient Pact | 19 | 19 | YES |
| Chapter 3: Shadows Upon Adoulin | 29 | 29 | YES |
| Chapter 4: The Serpentine Labyrinth | 34 | 34 | YES |
| Chapter 5: Hades | 15 | 15 | YES |
| helpers.lua | 1 | 1 | -- |
| **Total** | **105 + helpers** | **106** | **YES** |

All mission scripts exist. No missing mission files.

## Epilogue Quests

| Quest | Status | Notes |
|-------|--------|-------|
| The Silent Forest (BCNM) | MISSING | No script found in scripts/missions/soa/ or scripts/quests/ |
| The Ygnas Directive (RoE) | MISSING | No script found |
| The Arciela Directive (RoE) | MISSING | No script found |

## Battlefield/Instance Status (CRITICAL)

SoA missions reference multiple BCNM/instance fights in `_U` (underground) zones. Only ONE instance file exists:

| Mission | Instance Zone | Instance File Exists? | Status |
|---------|-------------|----------------------|--------|
| 2-7-1: Behind the Sluices | Rala_Waterways_U | YES | WORKS -- full instance with mob spawns, Arciela ally, custom WS logic |
| 3-6-3: Stonewalled | Cirdas_Caverns_U | NO | BLOCKED -- script catches Event 1000 but no instance to trigger it |
| 4-3: The Gates | Cirdas_Caverns_U | NO | BLOCKED -- same pattern, Event 1000 with no instance |
| 4-6: Balamor's Ruse | Rala_Waterways_U | NO (different instance) | BLOCKED -- needs separate instance, only behind_the_sluices exists |
| 5-2: Yggdrasil Beckons | Cirdas_Caverns_U + Yorcia_Weald_U | NO | BLOCKED -- needs two instances, neither exists |
| 5-3-2: Watery Grave | Rala_Waterways_U | NO (different instance) | BLOCKED -- needs separate instance |
| 5-4: Reckoning | Rakaznar_Turris (Event 32001) | NO | BLOCKED -- no battlefield implementation |
| 5-4-1: Abomination | Rakaznar_Turris (Event 32001) | NO | BLOCKED -- no battlefield implementation |

The `_U` zone directories (Cirdas_Caverns_U, Yorcia_Weald_U) exist but contain only IDs.lua and Zone.lua -- no instances/ subdirectory.

The mission scripts are written to handle the post-instance flow (catching Event 1000 or 32001 and advancing the mission), but the instances themselves do not exist to trigger those events.

## Spot-Check: Key Missions in Detail

### 1-1: Rumors from the West -- WORKS
- Talks to Darcia in Lower Jeuno (event 10117)
- Checks if player has 1M gil for skip option
- Grants Geomagnetron KI or pays to skip to mission 1-3
- Optional cutscenes in San d'Oria, Bastok, Windurst
- Properly sets mission status bits for each optional CS

### 1-5: Pioneer Registration -- WORKS
- Talk to Brenton in Western Adoulin (event 3)
- Rewards: 1000 bayld, Map of Adoulin KI, Pioneer's Badge KI
- Post-completion: enables Mog Garden access via Dangueubert (event 546)
- Multiple NPC dialogues unlocked after completion

### 2-7-1: Behind the Sluices -- WORKS (Instance Fight)
- Get Waterway Facility Crank KI from Storage Container in Rala Waterways
- Use KI on Sluice Gate 6 for cutscene, then enter gate
- Instance in Rala_Waterways_U: fight alongside Arciela vs 4 enemies
- Instance has full mob spawning (6 mobs), custom WS AI, victory detection
- On instance complete, sets mission status to 3, zones player back
- Return cutscene (event 353) completes mission
- This is the only fully implemented SoA instance

### 3-6-3: Stonewalled -- PARTIAL (No Instance)
- Gets Aureate Ball of Fur KI from Crawling Cave in Kamihr Drifts
- Should enter Cirdas_Caverns_U instance for battlefield
- Script catches Event 1000 from instance -- but instance does not exist
- Post-battle cutscene and completion logic is written
- **Players cannot progress past this point without GM intervention**

### 4-6: Balamor's Ruse -- PARTIAL (No Instance)
- Interesting implementation: mobs in Rala Waterways drop Consummate Simulacrum KI (20% chance)
- Party-wide KI distribution on mob death
- Needs Rala_Waterways_U instance for BCNM
- Script catches Event 1000 but instance does not exist
- **Players cannot progress past this point without GM intervention**

### 5-2: Yggdrasil Beckons -- PARTIAL (No Instances)
- Requires TWO separate instances: Cirdas_Caverns_U and Yorcia_Weald_U
- Pome KI collection from Leafallia, then instance entry
- Both blood sigils needed to complete mission
- Neither instance exists
- **Double-blocked: needs two missing instances**

### 5-4: Reckoning + 5-4-1: Abomination -- PARTIAL (No Battlefields)
- Both missions use Rakaznar_Turris Event 32001 for battlefield completion
- No battlefield implementation exists in Rakaznar_Turris
- These are the penultimate fights before the finale
- **Players cannot reach the ending**

### 5-5-1: The Light Within (Finale) -- WORKS (If Reachable)
- Final mission with elaborate cutscene chain
- Ceizak Battlegrounds -> Leafallia -> Eastern Adoulin
- Choice of 12 ring rewards + Councilor's Garb + Councilor's Cuffs
- Day-wait timer between steps
- Mission framework and reward logic are complete
- **Cannot be reached due to earlier instance blockers**

## TODO Comments in Mission Scripts

The codebase has 29 TODO comments across the mission scripts, indicating areas of incomplete implementation:

- **Instance Event 1000 assumptions** (6 occurrences): Multiple missions assume Event 1000 fires on instance clear -- this pattern is consistent but unverified since most instances do not exist
- **Battlefield Event 32001** (2 occurrences): Reckoning and Abomination assume this event for BCNM completion
- **Imprimatur system** (2 occurrences): helpers.lua imprimaturGate is entirely TODO
- **Minor items** (remaining): Capture verification notes, item drop rates, optional event parameters

## Coalition Dependency Check

Only 3 missions reference `imprimaturGate`:
1. **1-6: Life on the Frontier** (gateAmount=10) -- BLOCKED, impossible to pass
2. **1-8: Arciela Appears Again** (gateAmount=20) -- Would pass at fame 5+
3. **2-7-3: Yggdrasil** (gateAmount=30) -- Would pass at fame 4+

No missions directly check coalition rank. The coalition system is only connected to missions through the imprimatur gate function. If the gate is fixed (set to always pass), coalition status has no further impact on mission progression.

## Can the Full SoA Storyline Be Completed?

**No.** There are two categories of blockers:

### Category 1: Imprimatur Gate (Easy Fix)
- Mission 1-6 is blocked by the broken imprimaturGate function
- Fix: make imprimaturGate always return true (1 line change)
- This unblocks chapters 1-2 immediately

### Category 2: Missing Instances (Hard Fix)
Even with the gate fixed, players hit walls at:
- **3-6-3: Stonewalled** (Chapter 3) -- needs Cirdas_Caverns_U instance
- **4-3: The Gates** (Chapter 4) -- needs Cirdas_Caverns_U instance
- **4-6: Balamor's Ruse** (Chapter 4) -- needs Rala_Waterways_U instance (different from 2-7-1)
- **5-2: Yggdrasil Beckons** (Chapter 5) -- needs TWO instances
- **5-3-2: Watery Grave** (Chapter 5) -- needs Rala_Waterways_U instance
- **5-4: Reckoning** (Chapter 5) -- needs Rakaznar battlefield
- **5-4-1: Abomination** (Chapter 5) -- needs Rakaznar battlefield

### Maximum Progress Without GM Intervention
With the gate fix applied:
- Chapter 1: completable (missions 1-1 through 1-8)
- Chapter 2: completable (instance 2-7-1 Behind the Sluices works)
- Chapter 3: stuck at 3-6-3 Stonewalled
- Chapter 4: stuck at 4-3 The Gates (even if 3-6-3 skipped)
- Chapter 5: stuck at 5-2 Yggdrasil Beckons (even if ch3-4 skipped)

### Maximum Progress With GM Skips
A GM could `!addmission 12 <id>` to skip past each blocked instance. In that case, the cutscene/dialogue missions between instance fights should all work since they are fully scripted. The final mission (5-5-1: The Light Within) has complete reward logic.

## Checklist

| Item | Status | Notes |
|------|--------|-------|
| Script count matches wiki | WORKS | 105 mission scripts, all present |
| SoA entry from Jeuno | WORKS | Darcia in Lower Jeuno, waypoint transport |
| Chapter 1 progression | BLOCKED | Stuck at 1-6 due to imprimaturGate (easy fix) |
| Chapter 2 progression | BLOCKED | Blocked by 1-6; if skipped, completable (instance 2-7-1 works) |
| Chapter 3 progression | BLOCKED | Stuck at 3-6-3, no Cirdas_Caverns_U instance |
| Chapter 4 progression | BLOCKED | Stuck at 4-3, no Cirdas_Caverns_U instance |
| Chapter 5 progression | BLOCKED | Stuck at 5-2, no instances exist |
| Instance: Behind the Sluices (2-7-1) | WORKS | Full implementation with mobs, ally AI, completion logic |
| Instance: Stonewalled (3-6-3) | MISSING | No Cirdas_Caverns_U instance |
| Instance: The Gates (4-3) | MISSING | No Cirdas_Caverns_U instance |
| Instance: Balamor's Ruse (4-6) | MISSING | No Rala_Waterways_U instance for this mission |
| Instance: Yggdrasil Beckons (5-2) | MISSING | No Cirdas_Caverns_U or Yorcia_Weald_U instances |
| Instance: Watery Grave (5-3-2) | MISSING | No Rala_Waterways_U instance |
| Battlefield: Reckoning (5-4) | MISSING | No Rakaznar_Turris battlefield |
| Battlefield: Abomination (5-4-1) | MISSING | No Rakaznar_Turris battlefield |
| Finale: The Light Within (5-5-1) | WORKS | Complete reward logic, unreachable without GM skips |
| Epilogue quests | MISSING | Silent Forest, Ygnas/Arciela Directives not implemented |
| Auto-completes/stubs | NONE | No missions auto-complete; all have proper event/CS logic |
| Coalition rank dependency | NONE | No missions check coalition rank directly |
| Imprimatur gate dependency | BLOCKED | 3 missions use gate; 1-6 is impossible to pass |

## Blockers
1. **imprimaturGate blocks mission 1-6** -- Hardcoded `imprimatursSpent = 0` means the gate for mission 1-6 (gateAmount=10) never passes even at max fame. This blocks the entire SoA storyline at the 6th mission.
2. **7 missing instances/battlefields** -- Only 1 of 8 required instance fights is implemented (Behind the Sluices). The remaining 7 block chapters 3-5.
3. **Epilogue quests missing** -- The Silent Forest BCNM and RoE directives have no scripts.

## Fix Difficulty
- Imprimatur gate: **Easy** -- 1 line change in helpers.lua to return true
- Missing instances: **Massive** -- Each instance needs mob spawns, AI scripting, victory conditions, loot tables. 7 instances needed.
- Epilogue quests: **Medium** -- 3 quest scripts needed
- Overall SoA completion: **Massive** -- The non-instance missions are solid, but the instance gaps are the main barrier
