# Trust Gambit AI System -- Deep Dive

## Research Date: 2026-03-31
## Scope: Full gambit system architecture, Valaineral analysis, broken trust audit

---

## 1. How the Gambit System Works

### Architecture Overview

The gambit system is a priority-ordered behavior list that drives trust AI decision-making in combat. It consists of three layers:

1. **Lua trust scripts** (`scripts/actions/spells/trust/*.lua`) -- define gambits in `onMobSpawn`
2. **Lua gambit definitions** (`scripts/globals/gambits.lua`) -- enum aliases for Lua scripts
3. **C++ gambit engine** (`src/map/ai/helpers/gambits_container.cpp/.h`) -- evaluates and executes gambits
4. **C++ trust controller** (`src/map/ai/controllers/trust_controller.cpp/.h`) -- tick loop that calls the gambit engine

### How Gambits Are Defined (Lua Side)

Each trust script calls `mob:addGambit()` during `onMobSpawn`. The signature is:

```lua
mob:addGambit(target, conditions, reactions, retry_delay)
```

- **target** (`ai.t.*`): Who to evaluate/act on (SELF, PARTY, TARGET, MASTER, TANK, MELEE, RANGED, CASTER, TOP_ENMITY, PARTY_DEAD, etc.)
- **conditions**: Either a single `{ condition, arg }` or a table of `{ { cond1, arg1 }, { cond2, arg2 } }` -- ALL must be true (AND logic by default). Can wrap in `ai.l.OR(...)` for OR logic.
- **reactions**: Either a single `{ reaction_type, selector, selector_arg }` or a table of multiple reactions.
- **retry_delay** (optional): Seconds before this gambit can fire again. If 0 or omitted, no cooldown.

Example (Kupipi):
```lua
mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 25 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.POISON }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.POISONA })
mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH }, 60)
```

For TP skills (weaponskills/mobskills), trusts use a separate system:
```lua
mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.HIGHEST)
```

### The AI Decision Loop (C++ Side)

Every combat tick, `trust_controller.cpp::DoCombatTick()` calls `m_GambitsContainer->Tick(tick)`.

Inside `CGambitsContainer::Tick()`:

1. **Rate limiting**: A random delay of 1000-2500ms is added between actions (`m_lastAction`). Each trust also gets a small offset based on party position (10ms * position) to stagger actions.

2. **Busy check**: If the trust is already casting, using an ability, doing a WS, or using a ranged attack, skip this tick entirely.

3. **TP skills first**: If TP >= 1000, attempt to use a TP skill (WS/mobskill) before evaluating gambits. The TP trigger type controls when:
   - `ASAP` (0): Use immediately at 1000 TP
   - `OPENER` (2): Wait until another party member also has 1000+ TP
   - `CLOSER` (3): Hold TP indefinitely to close a skillchain
   - `CLOSER_UNTIL_TP` (4): Hold to close SC, but WS anyway at a TP threshold

4. **Gambit iteration**: Iterate through gambits **in order** (first-added = highest priority):
   - Check `retry_delay` -- skip if on cooldown
   - Resolve target list based on target selector
   - For each potential target, check ALL predicate groups -- all must pass
   - First matching target is selected
   - Execute the reaction(s)
   - Set `last_used` timestamp if `retry_delay > 0`
   - **BREAK** after the first matching gambit (only one gambit fires per tick)

5. **Return to step 1** on next tick (1-2.5 seconds later).

### Available Condition Types

| Enum | Name | Description |
|------|------|-------------|
| 0 | ALWAYS | Always true |
| 1 | HPP_LT | Target HP% < arg |
| 2 | HPP_GTE | Target HP% >= arg |
| 3 | MPP_LT | Target MP% < arg |
| 4 | TP_LT | Target TP < arg |
| 5 | TP_GTE | Target TP >= arg |
| 6 | STATUS | Target has status effect arg |
| 7 | NOT_STATUS | Target does NOT have status effect arg |
| 8 | STATUS_FLAG | Target has a status effect with flag arg (e.g., ERASABLE, DISPELABLE) |
| 9 | HAS_TOP_ENMITY | This trust has the highest enmity |
| 10 | NOT_HAS_TOP_ENMITY | This trust does NOT have highest enmity |
| 11 | SC_AVAILABLE | Skillchain window is open (tier 0) |
| 12 | NOT_SC_AVAILABLE | No skillchain window |
| 13 | MB_AVAILABLE | Magic burst window is open (tier > 0) |
| 14 | READYING_WS | Target is readying a WS |
| 15 | READYING_MS | Target is readying a mob skill |
| 16 | READYING_JA | Target is readying a job ability |
| 17 | CASTING_MA | Target is casting magic |
| 18 | RANDOM | Random chance (arg = percentage, 0-100) |
| 19 | NO_SAMBA | No samba effect active |
| 20 | NO_STORM | No storm effect active |
| 21 | PT_HAS_TANK | Party has a PLD or RUN |
| 22 | NOT_PT_HAS_TANK | Party has no PLD or RUN |
| 23 | IS_ECOSYSTEM | Target ecosystem matches arg |
| 24 | HP_MISSING | Target missing HP >= arg (absolute, not percentage) |

### Available Reaction Types

| Enum | Name | Description |
|------|------|-------------|
| 0 | ATTACK | Melee attack |
| 1 | RATTACK | Ranged attack |
| 2 | MA | Cast magic |
| 3 | JA | Use job ability |
| 4 | WS | Use weapon skill |
| 5 | MS | Use mob skill |

### Available Selectors

| Enum | Name | Description |
|------|------|-------------|
| 0 | HIGHEST | Best available in spell family |
| 1 | LOWEST | Worst available (TODO -- not implemented) |
| 2 | SPECIFIC | Exact spell/ability by ID |
| 3 | RANDOM | Random from available |
| 4 | MB_ELEMENT | Best spell matching magic burst element |
| 5 | SPECIAL_AYAME | Ayame-specific WS logic |
| 6 | BEST_AGAINST_TARGET | Best spell against target weakness |
| 7 | BEST_SAMBA | Best samba for level/party comp |
| 8 | HIGHEST_WALTZ | Best waltz affordable by TP |
| 9 | ENTRUSTED | Best Indi spell for master (GEO) |
| 10 | BEST_INDI | Best Indi spell for party |
| 11 | STORM_DAY | Storm matching current day |
| 12 | HELIX_DAY | Helix matching current day |
| 13 | EN_MOB_WEAKNESS | Enspell against mob weakness |
| 14 | STORM_MOB_WEAKNESS | Storm against mob weakness |
| 15 | HELIX_MOB_WEAKNESS | Helix against mob weakness |

### Spell Level Gating

In `CGambitsContainer::AddGambit()`, when adding a gambit with `G_REACTION::MA` and `G_SELECT::SPECIFIC`, the system calls `spell::CanUseSpell()` to check if the trust can use that spell at its current level. If it cannot, **the entire gambit is silently discarded** and never added to the gambit list.

This is the primary reason trusts break at low levels -- spells like Flash (level 37 Divine Magic) or high-tier Cures get gated out. If a trust's entire gambit list is level-gated spells, it ends up with zero gambits.

For `G_SELECT::HIGHEST` (spell family), the check happens at execution time via `SpellContainer->GetBestAvailable()`, which returns the highest-level spell the trust can cast at its current level. This degrades gracefully.

For `G_REACTION::JA` (job abilities), there is **NO level check at AddGambit time**. The level check happens at execution time through the recast/ability system. However, the ability will simply fail silently if the trust is too low level.

---

## 2. Valaineral Analysis

### File: `scripts/actions/spells/trust/valaineral.lua`

Valaineral has exactly 4 gambits:

```lua
-- Gambit 1: Provoke when not holding top enmity
mob:addGambit(ai.t.SELF, { ai.c.NOT_HAS_TOP_ENMITY, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })

-- Gambit 2: Flash when target doesn't have Flash debuff
mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH })

-- Gambit 3: Sentinel when self doesn't have Sentinel buff
mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })

-- Gambit 4: Cure party members below 50% HP
mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 50 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
```

### Why Provoke Feels Like 90 Seconds

Provoke's actual recast time from `abilities.sql` is **30 seconds** (column: recastTime = 1800 centiseconds = 30 seconds for players, but the recast_delay column = 30).

However, the 90-second feeling comes from multiple compounding delays:

1. **Gambit tick rate**: 1-2.5 seconds random delay between ticks
2. **Priority ordering**: Provoke is gambit #1, BUT:
   - The gambit only fires when `NOT_HAS_TOP_ENMITY` is true
   - If Valaineral already has top enmity, gambit #1 is skipped, and the system checks gambits #2-#4 instead
   - When he loses hate, it may take 1-2.5s for the next tick
3. **One action per tick**: Only ONE gambit fires per tick. If Flash or Sentinel fires first on a tick where Provoke is also needed, Provoke waits another 1-2.5 seconds.
4. **Spell casting lock**: While casting Flash or Cure, the trust is in `CMagicState` and all gambit evaluation is blocked until the cast completes (cast time + recovery)
5. **No retry_delay on any gambit**: None of Valaineral's gambits have retry cooldowns (good for responsiveness, but means Flash/Sentinel/Cure compete equally for every tick)

### What Valaineral is Missing vs Retail

On retail, Valaineral uses: Provoke, Flash, Shield Bash, Sentinel, and generates enmity through cures.

**Missing from his gambit list:**
- **Shield Bash** (ability 46, recast 60s, PLD level 15) -- instant enmity + stun. Not present at all.
- **No cure-for-enmity strategy** -- His cure gambit only fires at HPP < 50. On retail, tank trusts cure more aggressively to generate enmity. Should be HPP < 75 or even HPP < 85.
- **No Rampart** -- Additional party defense ability.
- **Sentinel priority is wrong** -- Sentinel (gambit #3) fires whenever the buff isn't up, consuming a tick that could be used for Provoke. Sentinel has a 300-second recast and 30-second duration, so this gambit fires once then goes on a very long natural recast cooldown, but still wastes a tick early in battle.

### Why Hate is So Weak

The core problem: **Valaineral generates almost zero CE (Cumulative Enmity)**.

- Provoke generates a fixed 1800 CE. Good but only every 30s at best.
- Flash generates 180 CE from the spell landing. Very low.
- Sentinel generates 0 CE directly -- it is a defensive buff.
- Cure generates CE based on HP healed. At 50% HP threshold, he rarely cures.
- He has NO Shield Bash (300 CE from damage + 300 CE from stun).
- He has NO repeated small cures to generate ongoing CE.

A single WS from a DD trust or the player can generate 1000+ CE, easily overtaking Valaineral's Provoke.

### Flash Level Gating

Flash requires level 37 (Divine Magic). At `AddGambit` time, `spell::CanUseSpell()` checks the trust's level. If the player (and thus the trust) is below level 37, the Flash gambit is **silently dropped**. This means at low levels, Valaineral has only 3 or 2 working gambits.

---

## 3. Trusts With No Gambits (Auto-Attack Only)

### Count: 71 out of 120 trusts have NO gambits and NO TP skill settings

These trusts only auto-attack. Their `onMobSpawn` does nothing beyond setting teamwork messages.

The remaining 49 trusts have at least one `addGambit` or `setTrustTPSkillSettings` call.

### Important Trusts That Should Have Gambits But Don't

| Trust | Role on Retail | Current State |
|-------|---------------|---------------|
| **Zeid** | DRK -- Absorb spells, Souleater, Last Resort, Stun | Auto-attack only |
| **Iroha II** | SAM/WHM hybrid -- cures, Third Eye, Seigan, Meditate | Auto-attack only |
| **August** | PLD/RUN tank -- top tank trust on retail | Has TP skill settings only, no gambits (no Provoke, Flash, or cures) |
| **Arciela II** | WHM healer on retail | Auto-attack only |
| **Star Sibyl** | WHM healer on retail | Auto-attack only |
| **Ingrid II** | PLD/WHM support | Auto-attack only |
| **D.Shantotto** | BLM nuker -- should nuke | Auto-attack only |
| **Lilisette** | DNC support -- waltzes, sambas, steps | Auto-attack only |
| **Amchuchu** | RUN tank on retail -- Foil, Flash, cures | Auto-attack only |
| **Balamor** | DRK/BLM -- Stun, nukes, absorbs | Auto-attack only |
| **Aldo** | NIN/WAR -- Utsusemi, Provoke | Auto-attack only |
| **Halver** | PLD -- should tank like Trion | Auto-attack only |
| **Mildaurion** | PLD/WHM -- tank/healer | Auto-attack only |

### Notable Missing Healer Trusts
- **Star Sibyl** (WHM) -- no cures at all
- **Arciela II** (WHM) -- no cures at all
- **Sakura** (WHM) -- no cures at all
- **Nashmeira** (PUP/WHM hybrid) -- no cures

### Notable Missing Tank Trusts
- **August** (PLD top-tier) -- has TP settings but zero gambits, no Provoke/Flash/Sentinel
- **Amchuchu** (RUN) -- no gambits at all
- **Halver** (PLD) -- no gambits at all

---

## 4. Level Scaling -- Why Trusts Break Below Level 30-40

### How Level Scaling Works

From `trustutils.cpp` line 376:
```cpp
// assume level matches master
PTrust->SetMLevel(PMaster->GetMLevel());
PTrust->SetSLevel(std::floor(PMaster->GetMLevel() / 2));
```

Trusts **always match the player's main job level**. Sub-job level is half of main level. This means a level 20 player gets level 20 trusts.

### The Level Gating Problem

The level gating happens at two points:

**At gambit creation (`AddGambit`):**
- For `MA` + `SPECIFIC` reactions, `spell::CanUseSpell()` is called
- If the trust's level is too low to cast the spell, the gambit is silently discarded
- Example: Flash requires level 37 Divine Magic. A level 20 PLD trust loses its Flash gambit entirely.

**At execution time:**
- For `MA` + `HIGHEST` (spell family), `SpellContainer->GetBestAvailable()` returns the best spell the trust CAN cast. This degrades gracefully (e.g., Cure I instead of Cure IV).
- For `JA` reactions, the ability executes through `trust_controller::Ability()` which checks the recast container. The ability system itself gates by level, so a level 10 trust can't use level 30 Provoke.

### Key Ability Level Requirements

| Ability | Required Level | Impact |
|---------|---------------|--------|
| Provoke | WAR 5 | Available very early -- works fine |
| Flash | PLD 37 (spell) | Gambit silently dropped below level 37 |
| Sentinel | PLD 30 | Available from level 30 |
| Shield Bash | PLD 15 | Available early -- but Valaineral doesn't have it |
| Hasso | SAM 25 | Ayame loses this gambit below 25 |
| Third Eye | SAM 15 | Available from 15 |
| Meditate | SAM 30 | Ayame loses this below 30 |
| Convert | RDM 40 | Koru-Moru loses this below 40 |

### Why Level 30-40 is the Breakpoint

Most tank trusts have their gambits built around:
- Provoke (level 5 WAR) -- works at low level
- Flash (level 37 spell) -- **dropped below level 37**
- Sentinel (level 30 JA) -- **fails below level 30**

So below level 30-37, tank trusts like Valaineral and Trion have only 1-2 working gambits out of 3-4. Below level 5, even Provoke is gone.

Healer trusts fare better because their Cure gambits use `ai.s.HIGHEST` (spell family), which gracefully downgrades. But buff spells using `ai.s.SPECIFIC` get dropped at low levels (e.g., Protect II, Haste).

---

## 5. Gambit Definition Format Reference

### Minimal Trust (Auto-Attack Only)
```lua
spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)
    -- No gambits = auto-attack only
end
```

### Well-Implemented Tank (Valaineral as-is)
```lua
spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)
    mob:addGambit(ai.t.SELF, { ai.c.NOT_HAS_TOP_ENMITY, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })
    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 50 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
end
```

### Well-Implemented Healer (Kupipi)
```lua
spellObject.onMobSpawn = function(mob)
    -- Priority 1: Emergency heal
    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 25 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
    -- Priority 2: Wake sleeping party members
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SLEEP_I }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE })
    -- Priority 3: Regular heal
    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 75 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
    -- Priority 4: Buffs
    mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.PROTECT }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PROTECTRA })
    -- Priority 5+: Status removal, debuffs
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.POISON }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.POISONA })
    -- ...
    mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.NO_MOVE)
end
```

### Well-Implemented Support (Koru-Moru RDM)
```lua
spellObject.onMobSpawn = function(mob)
    mob:addGambit(ai.t.SELF, { ai.c.MPP_LT, 5 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.CONVERT })
    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 50 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
    mob:addGambit(ai.t.MELEE, { ai.c.NOT_STATUS, xi.effect.HASTE }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.HASTE })
    mob:addGambit(ai.t.CASTER, {
        { ai.c.NOT_STATUS, xi.effect.REFRESH },
        { ai.c.NOT_STATUS, xi.effect.SUBLIMATION_ACTIVATED },
    }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.REFRESH })
    -- Multiple condition groups are AND-ed together
    mob:addGambit(ai.t.TARGET, { ai.c.STATUS_FLAG, xi.effectFlag.DISPELABLE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.DISPEL })
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.DIA }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.DIA }, 60)
    -- 60 = retry_delay in seconds (don't reapply DIA spam)
    mob:setAutoAttackEnabled(false)
    mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.NO_MOVE)
end
```

### TP Skill Setup (Ayame SAM)
```lua
spellObject.onMobSpawn = function(mob)
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.HASSO }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.HASSO })
    mob:addGambit(ai.t.SELF, { ai.c.HAS_TOP_ENMITY, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.THIRD_EYE })
    mob:addGambit(ai.t.SELF, { ai.c.TP_LT, 1000 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.MEDITATE })
    mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.SPECIAL_AYAME)
end
```

### Key Pattern Notes

- **Gambit order = priority order**: First gambit added is checked first every tick
- **Only one gambit fires per tick**: ~1-2.5 second intervals
- **Use `ai.s.HIGHEST` for graceful level scaling**: Spell family selection degrades by level
- **Use `ai.s.SPECIFIC` only when necessary**: These get silently dropped if level-gated
- **retry_delay (4th arg)**: Use for debuffs/buffs that shouldn't spam (e.g., 60 for Dia, Slow)
- **setMobMod TRUST_DISTANCE**: Set to NO_MOVE for casters, MELEE (default) for melee

---

## 6. Comparison: Good Trust vs Broken Trust vs Valaineral

### Kupipi (WHM Healer) -- GOOD
- 15 gambits covering emergency heals, status removal, buffs, debuffs
- Uses `ai.s.HIGHEST` for cures (level-scales gracefully)
- Uses `ai.s.SPECIFIC` for status removal spells
- Correct priority: emergency cure > sleep wake > regular cure > buffs > status > debuffs
- Set to NO_MOVE (stays back, doesn't run into melee)

### Koru-Moru (RDM Support) -- GOOD
- 12 gambits covering Convert, cures, Haste, Refresh, Phalanx II, Dispel, debuffs, buffs
- Uses target selectors well: MELEE for Haste, CASTER for Refresh, TANK for Phalanx, TOP_ENMITY for tank buffs
- Multiple conditions (AND logic) to avoid overwriting buffs
- retry_delay on debuffs to prevent spam
- Auto-attack disabled, NO_MOVE positioning

### Valaineral (PLD Tank) -- MEDIOCRE
- Only 4 gambits, missing Shield Bash entirely
- Cure threshold too low (50%) -- should be 75-85% for enmity generation
- No priority management -- Sentinel wastes ticks early in fight
- No retry_delay tuning
- Result: barely holds hate, WS from DD easily pulls

### Zeid (DRK) -- BROKEN (auto-attack only)
- Should have: Last Resort, Souleater, Absorb-TP, Stun, dark magic
- Has: nothing. Just auto-attacks.

### August (PLD Top Tank) -- ALMOST BROKEN
- Has `setTrustTPSkillSettings` (CLOSER_UNTIL_TP, HIGHEST, 2500) and `setMobSkillAttack(1197)`
- Has ZERO gambits -- no Provoke, no Flash, no Sentinel, no cures
- Result: auto-attacks and occasionally uses a weapon skill, but cannot tank

---

## 7. Summary of Findings

### Root Causes of Poor Trust Performance

1. **71/120 trusts (59%) have zero AI gambits** -- they only auto-attack. This is the single biggest issue.

2. **Valaineral's gambit list is too thin** -- only 4 gambits, missing Shield Bash, cure threshold too restrictive, no enmity generation strategy.

3. **Level gating silently drops gambits** -- `SPECIFIC` spell gambits are checked at AddGambit time and silently discarded if the trust is too low level. Trusts below level 37 lose Flash. No error, no fallback.

4. **One action per 1-2.5 second tick** -- combined with spell cast times, a trust can only perform an action every 3-6 seconds in practice. Tank trusts competing between Provoke/Flash/Sentinel/Cure can only use Provoke every 4th action at best.

5. **No shield bash generates significant enmity gap** -- Shield Bash is a PLD level 15 ability with 300 CE from damage. Its absence from Valaineral's script is a meaningful enmity loss.

### Recommended Fixes (For Future Implementation)

**Valaineral specifically:**
- Add Shield Bash gambit
- Raise cure threshold from HPP_LT 50 to HPP_LT 75
- Reorder gambits: Provoke first (already is), Shield Bash second, then Flash, then Cure, then Sentinel last
- Consider adding Rampart

**Broader trust system:**
- Implement gambits for the 71 trusts that have none
- Use `ai.s.HIGHEST` (spell family) instead of `ai.s.SPECIFIC` wherever possible for graceful level scaling
- Add fallback gambits for low-level scenarios
- Prioritize commonly-used trusts: August, Zeid, Iroha II, Arciela II, Star Sibyl, Amchuchu, Lilisette

### Key File Paths

| File | Purpose |
|------|---------|
| `scripts/globals/gambits.lua` | Lua enum definitions for gambit system |
| `scripts/globals/trust.lua` | Trust spawn/message utilities |
| `scripts/actions/spells/trust/*.lua` | Individual trust AI definitions |
| `src/map/ai/helpers/gambits_container.h` | C++ gambit data structures and enums |
| `src/map/ai/helpers/gambits_container.cpp` | C++ gambit evaluation engine |
| `src/map/ai/controllers/trust_controller.cpp` | C++ trust AI tick loop |
| `src/map/ai/controllers/trust_controller.h` | C++ trust controller header |
| `src/map/utils/trustutils.cpp` | Trust entity creation and level scaling |
| `src/map/lua/lua_baseentity.cpp` (line 15715+) | Lua bindings for addGambit |
| `sql/abilities.sql` | Ability recasts (Provoke=30s, Shield Bash=60s, Sentinel=300s) |
