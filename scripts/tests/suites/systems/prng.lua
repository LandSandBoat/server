describe('PRNG', function()
    it('can be forced to a specific seed', function()
        -- TODO: Do a proper packet based test i.e. /random
        local expected = { 134, 137, 452, 22, 351, 912, 471, 75, 570, 636 }
        local actual   = {}

        xi.test.world:setSeed(1)

        for _ = 1, 10 do
            table.insert(actual, math.random(1000))
        end

        assert.are.same(expected, actual)
    end)

    it('test seed does not leak', function()
        local expected = { 134, 137, 452, 22, 351, 912, 471, 75, 570, 636 }
        local actual   = {}

        for _ = 1, 10 do
            table.insert(actual, math.random(1000))
        end

        assert.no.same(expected, actual)
    end)
end)
