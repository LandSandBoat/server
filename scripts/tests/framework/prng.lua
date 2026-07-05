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

    -- Float ranges are a local extension: LuaJIT has a single number type, so the
    -- binding in luautils.cpp dispatches by value. Two-argument calls where either
    -- bound is fractional roll a double in [a, b); integral-valued bounds (7.0 == 7)
    -- keep stock integer semantics. The one-argument form always stays on the stock
    -- integer path so a fractional argument cannot silently move the lower bound
    -- from 1 to 0.

    it('math.random(a, b) with a fractional bound returns doubles in [a, b)', function()
        xi.test.world:setSeed(1)

        local sawFraction = false
        for _ = 1, kSamples do
            local value = math.random(2.4, 7.6)
            assert(value >= 2.4 and value < 7.6, string.format('math.random(2.4, 7.6) out of [2.4, 7.6): %.17g', value))
            if value ~= math.floor(value) then
                sawFraction = true
            end
        end

        assert(sawFraction, 'math.random(2.4, 7.6) should produce fractional values')
    end)

    it('math.random(a, b) with a sub-integer span rolls a real float range', function()
        -- The pattern math.random(0.7, 1.1) is used by self-destruct mobskills as a
        -- damage multiplier; under the old int-only dispatch it collapsed to a
        -- constant 1.
        xi.test.world:setSeed(1)

        local minSeen = math.huge
        local maxSeen = -math.huge

        for _ = 1, kSamples do
            local value = math.random(0.7, 1.1)
            assert(value >= 0.7 and value < 1.1, string.format('math.random(0.7, 1.1) out of [0.7, 1.1): %.17g', value))
            minSeen = math.min(minSeen, value)
            maxSeen = math.max(maxSeen, value)
        end

        assert(maxSeen > minSeen, 'math.random(0.7, 1.1) should vary, not collapse to a constant')
    end)

    it('math.random(a, b) with integral-valued bounds keeps stock integer semantics', function()
        -- 7.0 == 7 in LuaJIT, so a float range with integral bounds is not
        -- expressible; use a + math.random() * (b - a) for that.
        xi.test.world:setSeed(1)

        local seen = {}
        for _ = 1, kSamples do
            local value = math.random(2.0, 7.0)
            assert(value == math.floor(value), string.format('math.random(2.0, 7.0) returned a fraction: %.17g', value))
            assert(value >= 2 and value <= 7, string.format('math.random(2.0, 7.0) out of [2, 7]: %s', tostring(value)))
            seen[value] = true
        end

        assert(seen[2] and seen[7], 'math.random(2.0, 7.0) should reach both endpoints 2 and 7')
    end)

    it('math.random(n) with a fractional argument stays on the integer path', function()
        xi.test.world:setSeed(1)

        for _ = 1, kSamples do
            -- 2.4 rounds to 2; the result is an integer in [1, 2], never a float in [0, 2.4).
            local value = math.random(2.4)
            assert(value == math.floor(value), string.format('math.random(2.4) returned a fraction: %.17g', value))
            assert(value >= 1 and value <= 2, string.format('math.random(2.4) out of [1, 2]: %s', tostring(value)))
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
