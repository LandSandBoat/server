describe('PRNG', function()
    it('can be forced to a specific seed', function()
        local expected = { 134, 137, 452, 22, 351, 912, 471, 75, 570, 636 }
        local actual   = {}

        xi.test.world:setSeed(1)

        for _ = 1, 10 do
            table.insert(actual, math.random(1000))
        end

        for i = 1, #expected do
            assert(expected[i] == actual[i], string.format('Element %d: expected %d, got %d', i, expected[i], actual[i]))
        end
    end)

    it('test seed does not leak', function()
        local expected = { 134, 137, 452, 22, 351, 912, 471, 75, 570, 636 }
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
