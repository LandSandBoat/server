-- -----------------------------------------------------------------------------
-- Status effect container benchmark.
--
-- OFF BY DEFAULT. This file registers no tests unless the environment variable
-- XI_RUN_BENCHMARKS=1 is set, so it never runs in the normal suite / CI.
--
-- Two ways to read the results:
--
--  * Self-reported breakdown: each test times its sub-operations with os.clock
--    and prints "[BENCH] ..." lines (works anywhere, no profiler needed).
--
--  * Tracy: configure with TRACY_ENABLE (xi_test_tracy) and connect the Tracy
--    profiler GUI (tracy-profiler.exe) while running. The hot C++ zones
--    (AddStatusEffect, TickEffects, TickRegen, DeleteStatusEffects) show up
--    under the per-test zones.
--
-- Workload sizes are tunable from the environment:
--   XI_BENCH_ENTITIES  entities to spread effects across (default 50)
--   XI_BENCH_TICKS     effect ticks to advance in the tick test (default 100)
--   XI_BENCH_ROUNDS    repeat count for add/remove timing (default 30)
--   XI_BENCH_DRAIN_US  estimated network drain CPU per entity per tick (default 25)
-- -----------------------------------------------------------------------------

if os.getenv('XI_RUN_BENCHMARKS') ~= '1' then
    return
end

local function envNumber(name, default)
    local value = tonumber(os.getenv(name) or '')
    return (value and value > 0) and math.floor(value) or default
end

local kNumEntities          = envNumber('XI_BENCH_ENTITIES', 50)
local kNumTicks             = envNumber('XI_BENCH_TICKS', 100)
local kRounds               = envNumber('XI_BENCH_ROUNDS', 30)
local kDrainMicrosPerEntity = envNumber('XI_BENCH_DRAIN_US', 25)

local effects = {
    xi.effect.PROTECT,       xi.effect.SHELL,         xi.effect.REGEN,
    xi.effect.REFRESH,       xi.effect.HASTE,         xi.effect.BLINK,
    xi.effect.STONESKIN,     xi.effect.AQUAVEIL,      xi.effect.STR_BOOST,
    xi.effect.DEX_BOOST,     xi.effect.VIT_BOOST,     xi.effect.AGI_BOOST,
    xi.effect.INT_BOOST,     xi.effect.MND_BOOST,     xi.effect.CHR_BOOST,
    xi.effect.MAX_HP_BOOST,  xi.effect.MAX_MP_BOOST,  xi.effect.ACCURACY_BOOST,
    xi.effect.ATTACK_BOOST,  xi.effect.EVASION_BOOST, xi.effect.DEFENSE_BOOST,
}

describe('#benchmark Status Effect Container', function()
    ---@type CClientEntityPair[]
    local entities = {}

    -- effect-operations performed by one addAll()/removeAll() pass
    local opsPerPass = kNumEntities * #effects

    -- accumulated wall-clock spent in the modelled network drain
    local drainTime = 0

    setup(function()
        xi.test.world:tick()
        for i = 1, kNumEntities do
            entities[i] = xi.test.world:spawnPlayer({
                zone  = xi.zone.WEST_RONFAURE,
                job   = xi.job.WHM,
                level = 99,
            })
            entities[i]:setUnkillable(true)
        end
    end)

    local function addAll()
        for _, entity in ipairs(entities) do
            for _, effect in ipairs(effects) do
                entity:addStatusEffect(effect, { power = 10, tick = 3, duration = 7200, origin = entity })
            end
        end
    end

    local function removeAll()
        for _, entity in ipairs(entities) do
            for _, effect in ipairs(effects) do
                entity:delStatusEffect(effect)
            end
        end
    end

    -- TODO: Build this into the test harness
    local function drain()
        for _, entity in ipairs(entities) do
            entity.packets:clear()
        end

        local target = os.clock() + (kNumEntities * kDrainMicrosPerEntity) / 1e6
        while os.clock() < target do
            -- busy-wait: model the network tick occupying the main thread
        end

        drainTime = drainTime + (kNumEntities * kDrainMicrosPerEntity) / 1e6
    end

    -- Report wall-clock for a measured region, normalised per effect-operation.
    local function report(label, seconds, ops)
        print(string.format('[BENCH] %-22s %9.2f ms total | %8.3f us/op | %d ops',
            label, seconds * 1000, (seconds * 1e6) / ops, ops))
    end

    it(string.format('add / overwrite / remove (%d entities x %d effects, %d rounds)', kNumEntities, #effects, kRounds), function()
        local addFresh, addOver, remove = 0, 0, 0
        drainTime = 0

        for _ = 1, kRounds do
            -- Clear, then tick once (untimed) to force DeleteStatusEffects to actually
            -- erase the tombstones delStatusEffect leaves behind, so the timed addAll
            -- below inserts into a clean container instead of one full of dead entries.
            removeAll()
            xi.test.world:tick(xi.tick.EFFECT)
            drain() -- network tick

            local t0 = os.clock()
            addAll() -- fresh insert path
            addFresh = addFresh + (os.clock() - t0)
            drain() -- network tick

            t0 = os.clock()
            addAll() -- effect already present: overwrite/refresh path
            addOver = addOver + (os.clock() - t0)
            drain() -- network tick

            t0 = os.clock()
            removeAll()
            remove = remove + (os.clock() - t0)
            drain() -- network tick
        end

        report('add (fresh)', addFresh, kRounds * opsPerPass)
        report('add (overwrite)', addOver, kRounds * opsPerPass)
        report('remove', remove, kRounds * opsPerPass)
        report('network drain (est)', drainTime, kRounds * 4 * kNumEntities) -- 4 drains per round
    end)

    it(string.format('tick (%d entities x %d effects, %d ticks)', kNumEntities, #effects, kNumTicks), function()
        removeAll()
        addAll()
        drain()

        local elapsed = 0
        drainTime     = 0
        for _ = 1, kNumTicks do
            local t0 = os.clock()
            xi.test.world:tick(xi.tick.EFFECT)
            elapsed = elapsed + (os.clock() - t0)
            drain() -- network tick
        end

        removeAll()

        report('tick', elapsed, kNumTicks * opsPerPass)
        report('network drain (est)', drainTime, kNumTicks * kNumEntities)
    end)
end)
