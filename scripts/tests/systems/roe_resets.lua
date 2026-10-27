-----------------------------------
-- Records of Eminence resets
-----------------------------------
local vanquishMultipleEnemies = 4082 -- Daily
local signetBrb               = 3367 -- Weekly

describe('Records of Eminence resets', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
    end)

    it('clears daily records at JST midnight', function()
        player:setEminenceCompleted(vanquishMultipleEnemies)
        xi.test.world:tick(xi.tick.JST_DAY)

        assert(not player:getEminenceCompleted(vanquishMultipleEnemies), 'daily record is still complete')
    end)

    it('clears weekly records on Monday only', function()
        player:setEminenceCompleted(signetBrb)

        for _ = 1, 8 do
            xi.test.world:tick(xi.tick.JST_DAY)
            if JstDayOfTheWeek() == 1 then
                break
            end

            assert(player:getEminenceCompleted(signetBrb), 'weekly record cleared before Monday')
        end

        assert(not player:getEminenceCompleted(signetBrb), 'weekly record is still complete')
    end)
end)
