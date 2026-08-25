# Testing

`xi_test` embeds the equivalent of a fully functional `xi_map` server and executes various tests defined in the `scripts/tests` folder.

Helpers are available to simulate client interactions as if they had come from an actual FFXI client.

## Universal truths

- Tests run one at a time, top to bottom when reading a file.
- Each test gets a fresh PRNG seed. The seed is reset between test cases, so a case cannot rely on another case's random draws.
- State is **not** automatically reset between test cases. A player, mob or world value you mutate in one `it` block is still mutated in the next, unless you rebuild it (see `before_each`). 
  - The one exception is test doubles (`spy`/`stub`/`mock`), which revert automatically at the end of each case.

## Limitations

- Multi-process tests are not yet supported. It is not possible to spawn players in a way that emulates them being on different `xi_map` processes.
- World messages are not yet processed

## Getting Started

### Building xi_test

Follow the [Quick Start Guide](https://github.com/LandSandBoat/server/wiki/Quick-Start-Guide) to prepare all dependencies and build the binaries.

`xi_test` has the same requirements as a fully functioning `xi_map`, namely a working database with tables imported.

## Executing xi_test

In a terminal/shell/your IDE debug configuration, target the `xi_test` binary/launch target.

```shell
# See next sections for arguments
# Run everything, stops on first failure
./xi_test
# Run everything, but don't stop
./xi_test --keep-going
# Run ONLY tests in filepaths matching 'magic'
# Note: This supports regex
./xi_test --keep-going --file 'magic'
# Run ALL tests except in filenames matching 'magic'
# Note: This supports regex
./xi_test --keep-going --no-file 'magic'
# Run ONLY test cases (in all files) matching 'Chains of Promathia'
./xi_test --keep-going --filter 'Chains of Promathia'
# Run ALL test cases EXCEPT those matching 'Chains of Promathia'
./xi_test --keep-going --no-filter 'Chains of Promathia'
# Run all tests except those tagged with '#long'
./xi_test --keep-going --no-tag 'long'
# Mix and match arguments as desired
# Run tests tagged with '#magic' in filepaths matching 'systems'
./xi_test --keep-going --tag 'magic' --file 'systems'
```

## Arguments

| Arg          | Description                                                   | Example                   |
|--------------|---------------------------------------------------------------|---------------------------|
| --keep-going | Don't stop on test failure.                                   | --keep-going              |
| --verbose    | Always print logs.                                            | --verbose                 |
| --file       | Only execute files matching regex pattern.                    | --file 'smoke_test'       |
| --no-file    | Execute every files but the ones matching regex pattern.      | --no-file 'war'           |
| --filter     | Only execute test cases matching regex pattern.               | --filter 'Spell'          |
| --no-filter  | Execute every test cases but the ones matching regex pattern. | --no-filter 'Framework'   |
| --tag        | Only execute test cases containing tag.                       | --tag 'ci'                |
| --no-tag     | Execute every test cases but the ones containing tag.         | --no-tag 'long'           |
| --output     | Test report path (*.json)                                     | --output report.ctrf.json |

## Output formats

### terminal (gtest-like)

By default, `xi_test` will produce a colorized `gtest` style output.

This reporter cannot be disabled.

```shell
[ RUN      ] missions::Rise of the Zilart::ZM9 to ZM13::should complete ZM13 - The Gate of the Gods
[       OK ] missions::Rise of the Zilart::ZM9 to ZM13::should complete ZM13 - The Gate of the Gods
[==========] 108 tests ran. (37.567 s total)
[  PASSED  ] 108 tests.
```

Note that logs are only printed on test failures.

```shell
[ RUN      ] missions::Chains of Promathia::4-3 The Secrets of Worship::should complete the mission successfully
[  FAILED  ] missions::Chains of Promathia::4-3 The Secrets of Worship::should complete the mission successfully (369 ms)
  Error: scripts/tests/missions/cop.lua:542: Expected player to have key item RELIQUIARIUM_KEY
stack traceback:
        [C]: in function 'hasKI'
        scripts/tests/missions/cop.lua:542: in function <scripts/tests/missions/cop.lua:517>
  Test logs:
    [20:30:23][info][                 spawnPlayer:401] Spawning player in zone: 210
    [20:30:23][debu][           setThreadpoolSize:109] Setting async thread pool size to 15
    [20:30:23][info][                 spawnPlayer:413] Created test character ID: 20000016 in zone: 210
    [20:30:23][debu][                createSession:40] Creating session for 16.45.49.1
    [20:30:23][debu][                    InsertPC:223] CZone:: GM_Home IncreaseZoneCounter <1> T20000016
    [20:30:23][info][                    skipTime:120] Skipping 3 seconds
    [20:30:23][warn][                 addMission:7955] Lua::addMission: player has a current mission (6)
    [20:30:23][info][                     gotoZone:99] Player T20000016 zoning to zone ID: 26
    [20:30:23][debu][         DecreaseZoneCounter:586] CZone:: GM_Home DecreaseZoneCounter <0> T20000016
    [20:30:23][info][             sendZonePackets:115] Reloading character 20000016 for zone change
    [20:30:23][debu][                    InsertPC:223] CZone:: Tavnazian_Safehold IncreaseZoneCounter <6> T20000016
    [20:30:23][info][                    skipTime:120] Skipping 3 seconds
    [20:30:23][info][                       finish:87] Sending event finish packet for event ID: 111
    [20:30:23][info][                     gotoZone:99] Player T20000016 zoning to zone ID: 25
    [20:30:23][debu][         DecreaseZoneCounter:586] CZone:: Tavnazian_Safehold DecreaseZoneCounter <5> T20000016
    [20:30:23][info][             sendZonePackets:115] Reloading character 20000016 for zone change
    [20:30:23][debu][                    InsertPC:223] CZone:: Misareaux_Coast IncreaseZoneCounter <2> T20000016
    [20:30:23][info][                    skipTime:120] Skipping 3 seconds
    [20:30:23][info][                       finish:87] Sending event finish packet for event ID: 9
    [20:30:23][info][                    skipTime:120] Skipping 1 seconds
    [20:30:23][debu][         DecreaseZoneCounter:586] CZone:: Misareaux_Coast DecreaseZoneCounter <1> T20000016
    [20:30:23][info][             sendZonePackets:115] Reloading character 20000016 for zone change
    [20:30:23][warn][                   OnZoneIn:1989] Attempt to Zone In player to invalid/disabled zone 28.
    [20:30:23][warn][                      process:82] GP_CLI_COMMAND_LOGIN: player tried to enter zone that was invalid or out of range
    [20:30:23][warn][                      process:83] GP_CLI_COMMAND_LOGIN: dumping player `T20000016` to homepoint!
    [20:30:23][info][                    skipTime:120] Skipping 3 seconds
    [20:30:23][info][             sendZonePackets:115] Reloading character 20000016 for zone change
    [20:30:23][debu][                    InsertPC:223] CZone:: unknown IncreaseZoneCounter <2> T20000016
    [20:30:23][info][                    skipTime:120] Skipping 3 seconds
    [20:30:23][info][                     gotoZone:99] Player T20000016 zoning to zone ID: 28
    [20:30:23][debu][           setThreadpoolSize:109] Setting async thread pool size to 15
    [20:30:23][info][                   LoadZones:753] Loading 1 zones
    [20:30:23][debu][                         wait:86] Waiting for async 2 tasks to complete on 15 workers
    [20:30:23][debu][                         wait:95] All async tasks completed
    [20:30:23][info][                 LoadNPCList:270] Loading NPCs
    [20:30:23][debu][                         wait:86] Waiting for async 1 tasks to complete on 15 workers
    [20:30:23][debu][                         wait:95] All async tasks completed
    [20:30:23][info][                 LoadNPCList:362] Loading NPC scripts
    [20:30:23][info][                 LoadMOBList:392] Loading Mobs
    [20:30:23][debu][                         wait:86] Waiting for async 1 tasks to complete on 15 workers
    [20:30:23][debu][                         wait:95] All async tasks completed
    [20:30:23][info][                 LoadMOBList:642] Loading Mob scripts
    [20:30:23][debu][           setThreadpoolSize:109] Setting async thread pool size to 1
    [20:30:23][debu][         DecreaseZoneCounter:586] CZone:: unknown DecreaseZoneCounter <1> T20000016
    [20:30:23][info][             sendZonePackets:115] Reloading character 20000016 for zone change
    [20:30:23][debu][                    InsertPC:223] CZone:: Sacrarium IncreaseZoneCounter <1> T20000016
    [20:30:23][info][                    skipTime:120] Skipping 3 seconds
    [20:30:23][info][                       finish:87] Sending event finish packet for event ID: 6
    [20:30:23][info][                    skipTime:120] Skipping 1 seconds
[==========] 108 tests ran. (34.866 s total)
[  PASSED  ] 107 tests.
[  FAILED  ] 1 test, listed below:
[  FAILED  ] missions::Chains of Promathia::4-3 The Secrets of Worship::should complete the mission successfully
```

### CTRF

`--output xxx.json` will produce a [CTRF](https://ctrf.io/docs/intro) JSON file.

The file will be created at the end of the run, at the desired path.

## Directory structure

Tests must be located in `scripts/tests`, if possible nested in the appropriate folders pertaining to their kind.

Create subfolders as needed so that individual test files remain relatively short.

Examples:

- `scripts/tests/missions/cop.lua`
- `scripts/tests/jobs/brd.lua`
- `scripts/tests/systems/magic/immunobreak.lua`
- `scripts/tests/systems/magic/magicburst.lua`

## Test structure

A test suite must contain an arbitrary number of nested `describe` blocks, and at least one `it` block.

```lua
-- Minimally viable test
describe('True', function()
  it('is true', function()
    assert(true)
  end)
end)
```

`describe` blocks can be nested to provide a human-readable delineation between different tests, or to support different `setup/teardowns` for each blocks.

## Test names

Test names are a concatenation of the file path and of each `describe` block. Care should be taken to ensure the resulting fully qualified name is an intelligible English sentence that conveys the right amount of context.

```lua
-- scripts/tests/magic/magic_burst.lua

describe('Magic burst', function()
  it('should increase damage', function()
    -- magic::Magic burst::should increase damage
    -- Actual code to cast a magic burst and assert
  end)
end)
```

It is also acceptable to describe tests using the naming convention of the system under test

```lua
-- scripts/tests/bindings/CBaseEntity.lua

describe('CBaseEntity', function()
  describe('getItems', function()
    it('should find owned items', function()
      -- bindings::CBaseEntity::getItems::should find owned items
      -- Test code goes here
    end)

    it('should not find unowned items', function()
      -- bindings::CBaseEntity::getItems::should not find unowned items
      -- Test code goes here
    end)
  end)
end)
```

### Tagging tests

You may optionally specify one or more tags in the test name.

These can be used to selectively include or exclude a group of loosely related tests when running `xi_test`.

```lua
describe('Tagged tests', function()
  describe('', function()
    it('is very #long #ci', function()
    end)

    it('magic related #magic', function()
    end)
  end)
end)
```

```shell
# Will run every tests except those tagged with #long
xi_test --no-tag long

# Will run only tests tagged with #magic
xi_test --tag magic
```

Arguments can be mixed in different ways, described in the "Arguments" section of this document.

## Designing a good test

Before writing any code, think about _what_ you are attempting to test and how you will go about it.

The framework is flexible enough to allow testing in various ways:

1. By simulating a FFXI client emitting packets to the server
2. By making use of existing Lua bindings

As an example if you wanted to test the magic system, you could either test against the Lua functions or emulate a client casting Stone.

In general, testing using client emulation is going to be the preferred way but intricate systems will benefit from also testing directly the inner functions.

Reusing the magic system example, given the amount of calculations and parameters that go into calculating the final value, it would be saner to test directly each function than to rely on a simulated Stone cast.

## Testing guide

### Test lifecycle functions

It is possible to define several functions that will execute at different time in the test lifecycle.

Lifecycle functions are always defined at the `describe` level.

**Only one of each kind can be specified at any given level!**

- Create nested describe blocks if you need finer test initialization.

#### setup() - Run once for current suite at the beginning

Use `setup()` to prepare an environment where each test case either does not strictly care about sharing state, or when designing test cases that build on the previous cases.

Assertions can be performed in the block.

Examples:

- Testing a mob properties, where the mob entity is not mutated during the test
- Testing several successive steps for a Quest

```lua
-- Retrieve Fafnir once and check some stats
describe('Fafnir', function()
  local fafnir
  local player

  setup(function()
    player = xi.test.world:spawnPlayer()

    -- Only retrieve Fafnir once
    fafnir = player.entities:get(zones[xi.zone.DRAGONS_AERY].mob.FAFNIR)
    assert(fafnir)
    fafnir:spawn()
  end)

  it('is spawned', function()
    assert(fafnir:isSpawned())
  end)

  it('has a lot of HP', function()
    assert(fafnir:getHP() > 10000)
  end)
end)

-- Another example with nested setup()
describe('Fafnir', function()
  local fafnir
  local player

  setup(function()
    player = xi.test.world:spawnPlayer()

    -- Only retrieve Fafnir once
    fafnir = player.entities:get(zones[xi.zone.DRAGONS_AERY].mob.FAFNIR)
    assert(fafnir)
    fafnir:spawn()
  end)

  describe('Test Fafnir drops', function()
    setup(function()
      -- Any setup code specific to this nested suite
    end)
  end)

  describe('Test Fafnir resistance', function()
    setup(function()
      -- Different setup code specific to this nested suite
    end)
  end)
end)
```

#### teardown() - Run once for current suite at the end

See `setup()`

#### before_each() - Run before every case

Use to prepare a clean isolated environment. This is the ****preferred way**** to ensure complete isolation between test cases.

Note that when building tests in this way, any step executed in a previous case may need to be repeated to get to the correct testable state.

```lua
describe('Treasure Hunter', function()
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.KUFTAL_TUNNEL, job = xi.job.THF, level = 75 })
    end)

    it('equals TH2 for a naked THF75', function()
        player.assert:hasModifier(xi.mod.TREASURE_HUNTER, 2)
    end)

    it('equals TH3 with Thiefs Knife', function()
        player:addItem(xi.item.THIEFS_KNIFE)
        player:equipItem(xi.item.THIEFS_KNIFE, nil, xi.slot.MAIN)
        player.assert:hasModifier(xi.mod.TREASURE_HUNTER, 3)
    end)

    it('equals TH4 with Thiefs Knife and Assassins Armlets', function()
        -- You have to give a Thief's Knife again, since player is now a brand new naked THF75
        player:addItem(xi.item.THIEFS_KNIFE)
        player:equipItem(xi.item.THIEFS_KNIFE, nil, xi.slot.MAIN)
        player:addItem(xi.item.ASSASSINS_ARMLETS)
        player:equipItem(xi.item.ASSASSINS_ARMLETS)
        player.assert:hasModifier(xi.mod.TREASURE_HUNTER, 4)
    end)
end)
```

#### after_each() - Run after each test case

See `before_each()`

#### Mixing lifecycle functions

It is possible to mix any of the functions. Per test case, they execute in the following order:

- setup() (once per suite, before the first case)
- before_each() (before every case)
- after_each() (after every case)
- teardown() (once per suite, after the last case)

`before_each` and `after_each` **inherit into nested `describe` blocks and stack**: the outer block's `before_each` runs before the inner block's. 

This is the idiomatic way to layer setup: put "everyone needs a player" in an outer `before_each` and "this sub-group also needs a Thief's Knife" in an inner one. 

See [`scripts/tests/framework/lifecycle.lua`](https://github.com/LandSandBoat/server/blob/base/scripts/tests/framework/lifecycle.lua) for the exact ordering and inheritance behaviour expressed as runnable tests.

```lua
describe('THF', function()
    local player

    -- Create a THF75 player once.
    setup(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.KUFTAL_TUNNEL, job = xi.job.THF, level = 75 })
    end)

    -- But clear the inventory and reequip a Thief's Knife before every case
    before_each(function()
        player:delContainerItems(xi.inv.INVENTORY)
        player:addItem(xi.item.THIEFS_KNIFE)
        player:equipItem(xi.item.THIEFS_KNIFE, nil, xi.slot.MAIN)
    end)

    it('can make lots of gils', function()
        -- Kill mobs, track drops, idk
    end)
end)
```

## Manipulating the world state

The global `xi.test.world` exposes a handful of methods to manipulate the state of the world.

See the [LLS documentation](https://github.com/LandSandBoat/server/blob/base/scripts/specs/test/CSimulation.lua) for a complete list, along with expected parameters

### spawnPlayer(params)

Creates a new player character. All parameters are optional; refer to the [LLS documentation](https://github.com/LandSandBoat/server/blob/base/scripts/specs/test/CSimulation.lua) for the authoritative, current list. At time of writing it accepts `zone`, `job`, `level`, `race` and `new` (spawn as a fresh character with zero playtime).

Prefer passing the initial job/level as parameters over mutating the player afterwards.

```lua
describe('xi_test', function()
    local player

    before_each(function()
        -- One-liner setup; no need to changeJob/setLevel by hand afterwards
        player = xi.test.world:spawnPlayer({ zone = xi.zone.KUFTAL_TUNNEL, job = xi.job.THF, level = 75 })
    end)

    -- The returned object also behaves like a CBaseEntity, so bindings work directly:
    -- player:changeJob(xi.job.WAR), player:addItem(...), etc.
end)
```

### tick(...) / tickEntity(CBaseEntity)

`tick()` moves the steady clock forward and executes the requested tasks. It is variadic and accepts one or more `xi.tick` task-boundary types. If no argument is provided, it will default to ticking each zone once.

Note that depending on the provided arguments, different tasks may execute.

`tickEntity()` will tick an entity AI independently without moving any clock or executing any task.

```lua
describe('xi_test', function()
    local player

    setup(function()
        player = xi.test.world:spawnPlayer()
    end)

    it('executes ticks', function()
        local mob = player.entities:get('Some_Mob')
        xi.test.world:tick()             -- tick zone once
        xi.test.world:tickEntity(mob) -- Only tick the mob
    end)
end)
```

### loadZone(zone)

Explicitly ask the map server to load a given zone.
In most cases it is not necessary as it is handled behind the scene when the player is moved across zones.

However during certain events teleporting the player to a different zone, the zone must be pre-loaded.

```lua
describe('xi_test', function()
    local player

    setup(function()
        player = xi.test.world:spawnPlayer()
    end)

    it('teleports player to Hall of the Gods', function()
        -- Upcoming CS will dump us in Hall of the Gods.
        xi.test.world:loadZone(xi.zone.HALL_OF_THE_GODS)

        player.bcnm:enter("_513", xi.battlefield.id.CELESTIAL_NEXUS)
        player.bcnm:expectWin()

        -- After the final cutscene, you appear in Hall of the Gods.
        player.assert:inZone(xi.zone.HALL_OF_THE_GODS)
    end)
end)
```

### skipTime(seconds)

Moves the **steady clock** forward by the given amount of seconds.

Depending on the desired outcome, you may still need to call `tick()` after `skipTime()`

Note: This has **NO** impact on the Vana'Diel clock!

```lua
describe('xi_test', function()
    local player

    setup(function()
        player = xi.test.world:spawnPlayer()
    end)

    it('can reuse items', function()
        -- Some arbitrary charged item
        local item = player:getItem(xxx)
        player.actions:useItem(player, item)
        xi.test.world:tick()
        -- Do some assertions here

        -- Skip time forward by 30 seconds and try again
        xi.test.world:skipTime(30)
        player.actions:useItem(player, item)
        xi.test.world:tick()
        -- Do some more assertions here
    end)
end)
```

### setVanaDay(xi.day) / setVanaTime(hour, minute) / skipToNextVanaDay()

Sets the **Vana'Diel clock** directly to some specific value.

This **does not impact the steady clock**.

```lua
xi.test.world:setVanaDay(xi.day.FIRESDAY)
xi.test.world:setVanaTime(6, 0)
xi.test.world:skipToNextVanaDay()
```

### setSeed(seed) / seed()

Sets the PRNG seed to a provided value, allowing deterministic random values for testing. With a fixed seed, `math.random` produces the same sequence on every run, which is what makes tests involving randomness (damage rolls, drop rates, proc chances) reproducible.

The seed is forcibly reset between test cases. Seed in `before_each` if a whole suite needs determinism; see [`scripts/tests/packets/s2c/0x028_battle2/base.lua`](https://github.com/LandSandBoat/server/blob/base/scripts/tests/packets/s2c/0x028_battle2/base.lua).

```lua
xi.test.world:setSeed(1)
local a = math.random(1000) -- deterministic given the seed
xi.test.world:setSeed(1)
local b = math.random(1000)
assert(a == b)              -- same seed, same sequence

xi.test.world:seed()        -- assign a fresh, non-deterministic seed
math.random(1000)           -- who knows!
```

## Simulating client interactions

The player object returned by CSimulation:spawnPlayer() contains a handful of helpers to simulate interactions as if they had originated from a legitimate game client.

Sections below will only present a handful of possible usage, refer to the LLS documentation for an up-to-date listing.

The helper namespaces below have grown well beyond what this page can enumerate. Treat the LLS specification files under [`scripts/specs/test/`](https://github.com/LandSandBoat/server/tree/base/scripts/specs/test) as the authoritative, always-current list of methods; the examples here are only representative of each category.

### Actions (player.actions)

[LLS documentation](https://github.com/LandSandBoat/server/blob/base/scripts/specs/test/CClientEntityPairActions.lua)

Pre-canned packets for the things a client can do. This namespace covers a broad and growing surface (combat, spells, abilities, trading, guild shops, crafting, item management, party/alliance), so consult the LLS file for the full list. A representative sample:

```lua
-- Combat
player.actions:engage(mob)
player.actions:useSpell(mob, xi.magic.spell.STONE)
player.actions:useWeaponskill(mob, xi.weaponskill.TACHI_FUDO)
player.actions:useAbility(mob, xi.jobAbility.PROVOKE)
player.actions:skillchain(mob, ws1, ws2) -- two or more weaponskills

-- Trading to an NPC (see the Events section for the expectedEvent argument)
player:addItem(xi.item.ORCISH_AXE)
player.actions:tradeNpc('Ambrotien', { xi.item.ORCISH_AXE }, { eventId = 2020 })

-- Guild shops
player.actions:guildBuy(xi.item.CHUNK_OF_TIN_ORE, 1)
player.actions:guildSell(xi.item.CHUNK_OF_TIN_ORE, 1)
local buyList = player.actions:guildBuyList() -- decoded, keyed by item ID

-- Crafting (inventory slots are resolved for you)
player.actions:craft(xi.item.FIRE_CRYSTAL, { xi.item.BRONZE_INGOT, xi.item.BRONZE_INGOT })

-- Item management
player.actions:moveItem(xi.inv.INVENTORY, srcSlot, xi.inv.MOGSATCHEL, quantity)
```

### Entities (player.entities)

[LLS documentation](https://github.com/LandSandBoat/server/blob/base/scripts/specs/test/CClientEntityPairEntities.lua)

Retrieval of and interaction with non-PC entities around the player. Entities can be queried by name, ID, or object, and the returned entity is wired with assertion helpers.

```lua
local mob = player.entities:get('Some_Mob') -- by name, ID, or entity object; raises if not found
mob.assert:isAlive()

-- Walk to an NPC and trigger it, expecting a particular event to start
player.entities:gotoAndTrigger('Ambrotien', { eventId = 2000, finishOption = 0 })

-- Combat convenience: claim and kill, optionally waiting for despawn
player:claimAndKillMob(mob, { waitForDespawn = true })
player.entities:killMobs()                 -- clear the whole zone
player.entities:killMobs({ 'Orcish Grunt' }) -- or a filtered subset
```

### Events (player.events)

[LLS documentation](https://github.com/LandSandBoat/server/blob/base/scripts/specs/test/CClientEntityPairEvents.lua)

Drive the event (cutscene) engine and assert on it. Most action helpers that can start an event (`trigger`, `gotoAndTrigger`, `tradeNpc`) accept an **`ExpectedEvent`** table describing what should happen:

```lua
---@class ExpectedEvent
---@field eventId?     integer  -- event that should start
---@field updates?     integer[] -- option values to send as event updates
---@field finishOption? integer -- option value used to finish the event

-- Expect event 2000 to start, then finish it with option 0
player.entities:gotoAndTrigger('Ambrotien', { eventId = 2000, finishOption = 0 })

-- Or drive the current event manually
player.events:update(nil, 1)   -- send an update to the in-progress event
player.events:finish()         -- finish the current event
player.events:expectNotInEvent() -- assert we are no longer in an event
```

**The `eventId`, `updates` and `finishOption` values must come from a real event dump; never invent them.** See the [Interaction Framework Migration guide](interaction-framework-migration.md) for how to obtain them.

### BCNM (player.bcnm)

[LLS documentation](https://github.com/LandSandBoat/server/blob/base/scripts/specs/test/CClientEntityPairBCNM.lua)

Enter and resolve battlefields.

```lua
-- Some battlefields dump the player into a different zone on win; pre-load it first.
xi.test.world:loadZone(xi.zone.HALL_OF_THE_GODS)

player.bcnm:enter('_513', xi.battlefield.id.CELESTIAL_NEXUS)
player.bcnm:killMobs()
player.bcnm:expectWin()
player.assert:inZone(xi.zone.HALL_OF_THE_GODS)
```

### Packets (player.packets)

[LLS documentation](https://github.com/LandSandBoat/server/blob/base/scripts/specs/test/CClientEntityPairPackets.lua)

Beyond emitting packets, this namespace lets you **inspect what the server sent back**, which is how you assert on server behaviour at the wire level:

```lua
player.packets:clear()                      -- drop any queued packets first
player.actions:guildSell(itemId, 1)
for _, pkt in pairs(player.packets:getIncoming()) do  -- raw incoming packets as Lua tables
    if pkt.type == 0x084 then
        -- inspect pkt.data bytes...
    end
end

-- Higher-level helper: 0x028 BATTLE2 action packets unpacked into structured tables
local actions = player.packets:actionPackets()
```

The BATTLE2 action suite ([`scripts/tests/packets/s2c/0x028_battle2/base.lua`](https://github.com/LandSandBoat/server/blob/base/scripts/tests/packets/s2c/0x028_battle2/base.lua)) is the reference example: it captures a real action packet with `actionparse`, stores the expected fields, and diffs them against `actionPackets()`. Its header documents the full capture-to-test workflow; follow it whenever asserting on captured packet data.

You can also emit specially crafted packets via FFI definitions.

This is not intended to be a replacement for commonly re-used packets who should live in the `actions` namespace.

```lua
local ffi = require('ffi')

ffi.cdef [[
    typedef struct {
        uint16_t id : 9;
        uint16_t size : 7;
        uint16_t sync;
    } GP_CLI_HEADER;

    // 0x0A1 - Random Request packet
    typedef struct {
        GP_CLI_HEADER header;
        uint32_t unknown00;          // Always 0
    } GP_CLI_COMMAND_DICE;
]]

describe('Packets', function()
    it('can emit arbitrary packets and parse responses', function()
        local p = ffi.new('GP_CLI_COMMAND_DICE')
        p.unknown00 = 0
        player.packets:send(0x0A2, p, ffi.sizeof(p))
    end)
end)

```

## Assertions

[LLS documentation](https://github.com/LandSandBoat/server/blob/base/scripts/specs/test/CTestEntityAssertions.lua)

Beyond the built-in Lua `assert`, `CLuaBaseEntity` are pre-wired for easy human readable assertions.

Exposed assertions can be negated by prepending with `no.`

Prefer exposed helpers over the built-in `assert()` as they take care of formatting error messages.

Assertions return themselves (until one of them forcefully emits an error, that is) and can be chained up.

Not all assertions are valid on all entity types. Mobs will generally have a much reduced set of valid assertions.

The available helpers cover zone, status effects/animations, modifiers, local variables, inventory items, gil, key items, missions, quests, nation rank and liveness. See the [LLS documentation](https://github.com/LandSandBoat/server/blob/base/scripts/specs/test/CTestEntityAssertions.lua) for the current, authoritative list rather than relying on this page. Chaining reads naturally:

```lua
-- from scripts/tests/missions/sandoria.lua
player.assert
    :hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.NONE)
    :hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)
```

```lua
describe('xi_test', function()
    local player

    setup(function()
        player = xi.test.world:spawnPlayer()
    end)

    it('asserts all the things', function()
        -- Basic Lua assert, perfectly serviceable
        -- Only downside: It will only print 'assertion failed!' if not passing a string
        assert(true)
        assert(not true, 'Expected condition to be false')

        -- Custom CLuaBaseEntity assertions
        player.assert:hasKI(xi.ki.BLUE_ACIDITY_TESTER)
        player.assert.no:hasKI(xi.ki.RED_ACIDITY_TESTER)

        -- Different syntax to chain assertions
        player.assert
            :hasKI(xi.ki.BLUE_ACIDITY_TESTER)
            .no:hasKI(xi.ki.RED_ACIDITY_TESTER)
    end)
end)
```

```shell
  Error: scripts/tests\missions\bastok.lua:64: Expected player NOT to have key item RED_ACIDITY_TESTER
```

## Test doubles

A variety of test doubles is available to test and assert nested systems.

**Test doubles are automatically reverted on test case end.**

### Spies: Observing parameters and results

[LLS documentation](https://github.com/LandSandBoat/server/blob/base/scripts/specs/test/CSpy.lua)

Spies allow the observation of specified functions, in order to assert if they were called during a test case, with the expected arguments and that they returned the expected values.

```lua
-- Boilerplate left out
describe('xi.spells.damage.calculateDayAndWeather', function()
  local player = ...
  local mob = ...

  it('increases damage with matching weather', function()
    -- Create a new spy and temporarily replace the global
    -- The global is automatically reverted when the case ends
    local s = spy('xi.spells.damage.calculateDayAndWeather')
    player:setMod(xi.mod.FORCE_EARTH_DWBONUS, 1)
    player:setWeather(xi.weather.SAND_STORM)
    
    -- This sends a packet.
    player.actions:useSpell(mob, xi.magic.spell.STONE)

    -- Assert that the function was called. Optional parameter specify count.
    s:called()
    
    -- Assert that the function was called with the following parameters
    s:calledWith(player, xi.magic.spell.STONE)

    -- Individual calls can be inspected
    assert(s.calls[1].returned == 1.25, 'Expected return to be 1.25')
  end)
end)
```

### Stubs: Replacing a global function

Stubs possess the same feature set as Spies but also allow specifying:

- A new implementation for the function (passed to `stub(path, fn)`)
- A direct result to be returned (passed to `stub(path, value)`, or set later with `s:returnValue(value)`)
- A side-effect function to be executed (`s:sideEffect(fn)`)

`mock(path, impl)` is an alias of `stub(path, impl)`; use whichever reads better.

```lua
-- from scripts/tests/systems/combat/knockback.lua
local s = stub('xi.combat.knockback.calculate')
mob:useMobAbility(xi.mobSkill.AQUA_BLAST, player, 0)
xi.test.world:skipTime(1)
s:called(1) -- assert the mob ability actually invoked knockback calculation
s:returnValue(xi.action.knockback.LEVEL5)
```

```lua
describe('Test Doubles', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()
    end)

    -- Stubs replace global functions with your own implementation
    -- They do not need to match params
    -- They can be instantiated in the following fashion
    describe('stub()', function()
        it('can replace global functions with a new implementation', function()
            player:setSkillLevel(xi.skill.BONECRAFT, 300)

            local s = stub('xi.crafting.getRealSkill', function()
                return 100
            end)

            assert(s)

            local level = xi.crafting.getRealSkill(player, xi.skill.BONECRAFT)
            assert(level == 100, string.format('Expected stubbed level of 100 but got %s', tostring(level)))
        end)

        it('does not leak across tests', function()
            player:setSkillLevel(xi.skill.BONECRAFT, 300)

            local level = xi.crafting.getRealSkill(player, xi.skill.BONECRAFT)
            assert(level == 30, 'Expected level of 30')
        end)

        it('can replace global functions with a direct result', function()
            player:setSkillLevel(xi.skill.BONECRAFT, 300)

            local s = stub('xi.crafting.getRealSkill', 100)
            assert(s)

            local level = xi.crafting.getRealSkill(player, xi.skill.BONECRAFT)
            assert(level == 100, string.format('Expected stubbed level of 100 but got %s', tostring(level)))
        end)

        it('can execute side-effects', function()
            player:setSkillLevel(xi.skill.BONECRAFT, 300)

            local s = stub('xi.crafting.getRealSkill')
            s:sideEffect(function()
                player:changeJob(xi.job.DRK)
            end)

            local level = xi.crafting.getRealSkill(player, xi.skill.BONECRAFT)
            assert(level == 30, string.format('Expected original level of 30 but got %s', tostring(level)))
            assert(player:getMainJob() == xi.job.DRK, 'Expected job to be DRK')
        end)
    end)
end)
```
