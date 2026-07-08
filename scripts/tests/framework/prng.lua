-- The number of draws used by the range/spread tests below. High enough to make
-- coverage failures (a missed endpoint, a skewed bucket) mean a real regression
-- rather than noise, low enough to keep the suite fast.
local kSamples = 10000

describe('math.random() contract', function()
    -- math.random is overridden in luautils.cpp to forward into xirand. These tests
    -- lock the surface scripts rely on: interval endpoints, integer-ness, and the
    -- half-open float contract. The 1-in-33-million rounding edge (a float draw
    -- landing exactly on the excluded max) is locked at compile time by the
    -- static_asserts in src/test/tests/rng_spread_tests.cpp; these tests lock the
    -- everyday shape of the API.

    it('math.random() returns floats in [0, 1)', function()
        xi.test.world:setSeed(1)

        for _ = 1, kSamples do
            local value = math.random()
            assert(value >= 0 and value < 1, string.format('math.random() out of [0, 1): %.17g', value))
        end
    end)

    it('math.random(n) returns integers in [1, n] and reaches both endpoints', function()
        xi.test.world:setSeed(1)

        local seen = {}
        for _ = 1, kSamples do
            local value = math.random(6)
            assert(value >= 1 and value <= 6, string.format('math.random(6) out of [1, 6]: %s', tostring(value)))
            assert(value == math.floor(value), 'math.random(6) should return a whole number')
            seen[value] = true
        end

        assert(seen[1], 'math.random(6) never produced its lower endpoint 1')
        assert(seen[6], 'math.random(6) never produced its upper endpoint 6')
    end)

    it('math.random(n, m) is inclusive of both endpoints', function()
        xi.test.world:setSeed(1)

        local seen = {}
        for _ = 1, kSamples do
            local value = math.random(-3, 3)
            assert(value >= -3 and value <= 3, string.format('math.random(-3, 3) out of range: %s', tostring(value)))
            seen[value] = true
        end

        assert(seen[-3], 'math.random(-3, 3) never produced its lower endpoint -3')
        assert(seen[3], 'math.random(-3, 3) never produced its upper endpoint 3')
    end)

    it('math.random(n, n) returns n', function()
        xi.test.world:setSeed(1)

        for _ = 1, 100 do
            assert(math.random(4, 4) == 4, 'math.random(4, 4) should always return 4')
            assert(math.random(1) == 1, 'math.random(1) should always return 1')
        end
    end)

    -- math.random mimics stock Lua exactly: every argument form yields integers
    -- except the zero-argument call. Fractional bounds are rounded to the nearest
    -- integer -- scripts wanting a float range must say so by name, via
    -- math.randomFloat.

    it('math.random(a, b) rounds fractional bounds to the nearest integer', function()
        xi.test.world:setSeed(1)

        local seen = {}
        for _ = 1, kSamples do
            -- 2.4 and 7.6 round to 2 and 8; the result is an integer in [2, 8].
            local value = math.random(2.4, 7.6)
            assert(value == math.floor(value), string.format('math.random(2.4, 7.6) returned a fraction: %.17g', value))
            assert(value >= 2 and value <= 8, string.format('math.random(2.4, 7.6) out of [2, 8]: %s', tostring(value)))
            seen[value] = true
        end

        assert(seen[2] and seen[8], 'math.random(2.4, 7.6) should reach both rounded endpoints 2 and 8')
    end)

    it('math.random(a, b) with a sub-integer span collapses to a constant', function()
        -- Both bounds of math.random(0.7, 1.1) round to 1, so the roll is always 1.
        -- Scripts wanting a fractional roll must use math.randomFloat(0.7, 1.1).
        for _ = 1, 100 do
            assert(math.random(0.7, 1.1) == 1, 'math.random(0.7, 1.1) should always return 1')
        end
    end)

    it('math.random(n) with a fractional argument rounds it', function()
        xi.test.world:setSeed(1)

        for _ = 1, kSamples do
            -- 2.4 rounds to 2; the result is an integer in [1, 2], never a float in [0, 2.4).
            local value = math.random(2.4)
            assert(value == math.floor(value), string.format('math.random(2.4) returned a fraction: %.17g', value))
            assert(value >= 1 and value <= 2, string.format('math.random(2.4) out of [1, 2]: %s', tostring(value)))
        end
    end)
end)

describe('math.randomInt() contract', function()
    -- Custom extension bound in luautils.cpp: identical to math.random(lower, upper),
    -- but explicit about its integer semantics at the call site.

    it('returns integers in [lower, upper] and reaches both endpoints', function()
        xi.test.world:setSeed(1)

        local seen = {}
        for _ = 1, kSamples do
            local value = math.randomInt(-3, 3)
            assert(value == math.floor(value), string.format('math.randomInt(-3, 3) returned a fraction: %.17g', value))
            assert(value >= -3 and value <= 3, string.format('math.randomInt(-3, 3) out of [-3, 3]: %s', tostring(value)))
            seen[value] = true
        end

        assert(seen[-3], 'math.randomInt(-3, 3) never produced its lower endpoint -3')
        assert(seen[3], 'math.randomInt(-3, 3) never produced its upper endpoint 3')
    end)

    it('rounds fractional bounds to the nearest integer', function()
        xi.test.world:setSeed(1)

        for _ = 1, kSamples do
            -- 2.4 and 7.6 round to 2 and 8.
            local value = math.randomInt(2.4, 7.6)
            assert(value == math.floor(value), string.format('math.randomInt(2.4, 7.6) returned a fraction: %.17g', value))
            assert(value >= 2 and value <= 8, string.format('math.randomInt(2.4, 7.6) out of [2, 8]: %s', tostring(value)))
        end
    end)

    it('math.randomInt(n, n) returns n', function()
        for _ = 1, 100 do
            assert(math.randomInt(4, 4) == 4, 'math.randomInt(4, 4) should always return 4')
        end
    end)
end)

describe('math.randomFloat() contract', function()
    -- Custom extension bound in luautils.cpp: always a double in [lower, upper),
    -- even when the bounds are integral-valued. This is the only way to request a
    -- float range with whole-number bounds -- LuaJIT cannot tell 7.0 from 7, so
    -- math.random(2.0, 7.0) necessarily rolls integers.

    it('returns doubles in [lower, upper) even with whole-number bounds', function()
        xi.test.world:setSeed(1)

        local sawFraction = false
        for _ = 1, kSamples do
            local value = math.randomFloat(2, 7)
            assert(value >= 2 and value < 7, string.format('math.randomFloat(2, 7) out of [2, 7): %.17g', value))
            if value ~= math.floor(value) then
                sawFraction = true
            end
        end

        assert(sawFraction, 'math.randomFloat(2, 7) should produce fractional values')
    end)

    it('rolls real float ranges with sub-integer spans', function()
        -- The self-destruct mobskills use math.randomFloat(0.7, 1.1) as a damage
        -- multiplier; with math.random this span would collapse to a constant 1.
        xi.test.world:setSeed(1)

        local minSeen = math.huge
        local maxSeen = -math.huge

        for _ = 1, kSamples do
            local value = math.randomFloat(0.7, 1.1)
            assert(value >= 0.7 and value < 1.1, string.format('math.randomFloat(0.7, 1.1) out of [0.7, 1.1): %.17g', value))
            minSeen = math.min(minSeen, value)
            maxSeen = math.max(maxSeen, value)
        end

        assert(maxSeen > minSeen, 'math.randomFloat(0.7, 1.1) should vary, not collapse to a constant')
    end)

    it('math.randomFloat(n, n) returns n', function()
        for _ = 1, 100 do
            assert(math.randomFloat(5, 5) == 5, 'math.randomFloat(5, 5) should always return 5')
        end
    end)
end)

describe('math.randomNormal() contract', function()
    -- math.randomNormal is bound in luautils.cpp on top of xirand's inverse-CDF
    -- sampler: one engine draw per call, exact truncation, no rejection loops.

    it('matches the requested mean and standard deviation', function()
        xi.test.world:setSeed(1)

        local sum   = 0
        local sumSq = 0

        for _ = 1, kSamples do
            local value = math.randomNormal(3.5, 1.5)
            sum   = sum + value
            sumSq = sumSq + value * value
        end

        local mean   = sum / kSamples
        local stddev = math.sqrt(sumSq / kSamples - mean * mean)

        assert(math.abs(mean - 3.5) < 0.05, string.format('Mean drifted: expected ~3.5, got %.5f', mean))
        assert(math.abs(stddev - 1.5) < 0.05, string.format('Stddev drifted: expected ~1.5, got %.5f', stddev))
    end)

    it('respects both truncation bounds', function()
        xi.test.world:setSeed(1)

        local minSeen = math.huge
        local maxSeen = -math.huge

        for _ = 1, kSamples do
            local value = math.randomNormal(3.5, 1.5, 2, 7)
            assert(value >= 2 and value <= 7, string.format('math.randomNormal(3.5, 1.5, 2, 7) out of [2, 7]: %.17g', value))
            minSeen = math.min(minSeen, value)
            maxSeen = math.max(maxSeen, value)
        end

        assert(maxSeen > minSeen, 'Truncated normal should vary, not collapse to a constant')
    end)

    it('supports one-sided bounds via nil', function()
        xi.test.world:setSeed(1)

        for _ = 1, kSamples do
            local lowerOnly = math.randomNormal(3.5, 1.5, 0)
            assert(lowerOnly >= 0, string.format('math.randomNormal(3.5, 1.5, 0) below lower bound: %.17g', lowerOnly))

            local upperOnly = math.randomNormal(3.5, 1.5, nil, 4)
            assert(upperOnly <= 4, string.format('math.randomNormal(3.5, 1.5, nil, 4) above upper bound: %.17g', upperOnly))
        end
    end)

    it('handles degenerate inputs', function()
        xi.test.world:setSeed(1)

        for _ = 1, 100 do
            -- Zero stddev collapses to mean, clamped into any bounds.
            assert(math.randomNormal(5, 0) == 5, 'math.randomNormal(5, 0) should always return 5')
            assert(math.randomNormal(5, 0, nil, 3) == 3, 'math.randomNormal(5, 0, nil, 3) should clamp to 3')
            assert(math.randomNormal(5, 0, 7) == 7, 'math.randomNormal(5, 0, 7) should clamp to 7')

            -- Empty interval returns the lower bound, mirroring math.random(n, n < m).
            assert(math.randomNormal(5, 1.5, 7, 2) == 7, 'math.randomNormal with inverted bounds should return lower')
        end
    end)

    it('reproduces the same stream for the same seed', function()
        local first = {}
        xi.test.world:setSeed(42)
        for _ = 1, 8 do
            table.insert(first, math.randomNormal(3.5, 1.5, 2, 7))
        end

        local second = {}
        xi.test.world:setSeed(42)
        for _ = 1, 8 do
            table.insert(second, math.randomNormal(3.5, 1.5, 2, 7))
        end

        for i = 1, 8 do
            assert(first[i] == second[i], string.format('Element %d: %.17g ~= %.17g', i, first[i], second[i]))
        end
    end)
end)

describe('PRNG distribution', function()
    it('math.random() spreads evenly across buckets', function()
        xi.test.world:setSeed(1)

        local buckets = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        local total   = 0

        for _ = 1, kSamples do
            local value = math.random()
            buckets[math.floor(value * 10) + 1] = buckets[math.floor(value * 10) + 1] + 1
            total = total + value
        end

        local ideal = kSamples / 10
        for i = 1, 10 do
            assert(
                math.abs(buckets[i] - ideal) < ideal * 0.2,
                string.format('Bucket %d skewed: expected ~%d, got %d', i, ideal, buckets[i])
            )
        end

        local mean = total / kSamples
        assert(math.abs(mean - 0.5) < 0.02, string.format('Mean drifted: expected ~0.5, got %.5f', mean))
    end)

    it('math.random(n) covers every value roughly evenly', function()
        xi.test.world:setSeed(1)

        local counts = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        for _ = 1, kSamples do
            local value   = math.random(10)
            counts[value] = counts[value] + 1
        end

        local ideal = kSamples / 10
        for i = 1, 10 do
            assert(
                math.abs(counts[i] - ideal) < ideal * 0.2,
                string.format('Value %d skewed: expected ~%d, got %d', i, ideal, counts[i])
            )
        end
    end)
end)

describe('PRNG usage patterns', function()
    -- Idioms used across scripts/, locked here so an engine or binding change that
    -- breaks them fails loudly instead of corrupting gameplay quietly.

    it('1 - math.random() is always a valid input to math.log()', function()
        -- Sampling transforms (e.g. Box-Muller for normal distributions) rely on
        -- math.random() < 1 so that math.log(1 - math.random()) is finite.
        xi.test.world:setSeed(1)

        for _ = 1, kSamples do
            local u = 1 - math.random()
            assert(u > 0, 'math.random() returned 1.0; log(0) would be -inf')

            local logValue = math.log(u)
            assert(logValue <= 0 and logValue == logValue, 'math.log(1 - math.random()) must be finite')
        end
    end)

    it('random angles stay strictly below 2 * pi', function()
        -- Pattern from npc_util.lua and mob repositioning scripts.
        xi.test.world:setSeed(1)

        for _ = 1, kSamples do
            local angle = math.random() * 2 * math.pi
            assert(angle >= 0 and angle < 2 * math.pi, string.format('Angle out of [0, 2*pi): %.17g', angle))
        end
    end)

    it('random table indexing never overruns', function()
        xi.test.world:setSeed(1)

        local t = { 'a', 'b', 'c', 'd', 'e', 'f', 'g' }
        for _ = 1, kSamples do
            assert(t[math.random(#t)] ~= nil, 'math.random(#t) produced an invalid index')
        end
    end)
end)

describe('PRNG', function()
    it('can be forced to a specific seed', function()
        local expected = { 141, 597, 964, 998, 667, 697, 572, 741, 488, 371 }
        local actual   = {}

        xi.test.world:setSeed(1)

        for _ = 1, 10 do
            table.insert(actual, math.random(1000))
        end

        for i = 1, #expected do
            assert(expected[i] == actual[i], string.format('Element %d: expected %d, got %d', i, expected[i], actual[i]))
        end
    end)

    it('reproduces the same float stream for the same seed', function()
        local first = {}
        xi.test.world:setSeed(42)
        for _ = 1, 8 do
            table.insert(first, math.random())
        end

        local second = {}
        xi.test.world:setSeed(42)
        for _ = 1, 8 do
            table.insert(second, math.random())
        end

        for i = 1, 8 do
            assert(first[i] == second[i], string.format('Element %d: %.17g ~= %.17g', i, first[i], second[i]))
        end
    end)

    it('produces a stable golden float stream', function()
        -- Bit-exact goldens for the default engine (Squirrel5 + canonical53 + the
        -- float narrowing in the math.random binding). The RNG stack is deterministic
        -- on all platforms, so any drift here is a real behavior change, not noise.
        local expected =
        {
            0.1404843523841196,
            0.96306491641577729,
            0.66603129130620931,
            0.57130454287094867,
            0.48767078198955727,
        }

        xi.test.world:setSeed(1)

        local actuals = {}
        for i = 1, #expected do
            actuals[i] = math.random()
        end

        for i = 1, #expected do
            assert(expected[i] == actuals[i], string.format('Element %d: expected %.17g, got %.17g', i, expected[i], actuals[i]))
        end
    end)

    it('test seed does not leak', function()
        local expected = { 141, 597, 964, 998, 667, 697, 572, 741, 488, 371 }
        local actual   = {}

        for _ = 1, 10 do
            table.insert(actual, math.random(1000))
        end

        -- Check that at least one element is different
        local allSame = true
        for i = 1, #expected do
            if expected[i] ~= actual[i] then
                allSame = false
                break
            end
        end

        assert(not allSame, 'Arrays should not be the same')
    end)
end)
