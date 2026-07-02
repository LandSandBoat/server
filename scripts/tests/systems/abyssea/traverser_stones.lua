describe('Traverser Stones', function()
    ---@type CClientEntityPair
    local player

    local function advanceUntilStonesIncrease(from)
        for _ = 1, 64 do
            if player:getAvailableTraverserStones() > from then
                return
            end

            xi.test.world:skipToNextVanaDay()
        end

        error('Traverser Stones did not accrue in time')
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
    end)

    it('does not accrue before the epoch is set', function()
        assert(player:getTraverserEpoch() == 0)
        assert(player:getAvailableTraverserStones() == 0)
    end)

    it('persists the epoch when set', function()
        player:setTraverserEpoch()

        assert(player:getTraverserEpoch() > 0)
    end)

    it('accrues one stone per interval', function()
        player:setTraverserEpoch()

        local baseline = player:getAvailableTraverserStones()
        advanceUntilStonesIncrease(baseline)
        assert(player:getAvailableTraverserStones() == baseline + 1)

        advanceUntilStonesIncrease(baseline + 1)
        assert(player:getAvailableTraverserStones() == baseline + 2)
    end)

    it('subtracts claimed stones from available', function()
        player:setTraverserEpoch()

        local baseline = player:getAvailableTraverserStones()
        advanceUntilStonesIncrease(baseline)

        local available = player:getAvailableTraverserStones()
        player:addClaimedTraverserStones(available)
        assert(player:getClaimedTraverserStones() == available)
        assert(player:getAvailableTraverserStones() == 0)
    end)
end)
