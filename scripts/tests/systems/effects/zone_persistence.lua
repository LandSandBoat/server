-- Zoning in clears the pending-persist flag, so anything that changes afterwards has to re-flag the character or the next zone reloads the stale row.
describe('Status effect persistence across zoning', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.WAR,
                level = 75,
                zone  = xi.zone.SOUTHERN_SAN_DORIA,
            })

        -- char_effects rows outlive the test, and a leftover effect dirties the flag for us
        player:delStatusEffect(xi.effect.PROTECT)
        player:delStatusEffect(xi.effect.DEDICATION)
    end)

    it('carries the remaining duration, not the original', function()
        player:addStatusEffect(xi.effect.PROTECT, { power = 50, duration = 1800, origin = player })
        player:gotoZone(xi.zone.EAST_RONFAURE)

        xi.test.world:skipTime(600)
        player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)

        local protect = player:getStatusEffect(xi.effect.PROTECT)
        assert(protect ~= nil, 'Protect should survive zoning')

        local remaining = protect:getTimeRemaining() / 1000
        assert(remaining > 1100 and remaining <= 1200,
            'expected ~1200s left after 600s elapsed, got ' .. tostring(remaining))
    end)

    it('carries a subPower changed after the effect was gained', function()
        player:addStatusEffect(xi.effect.DEDICATION, { power = 30, subPower = 2500, duration = 3600, origin = player })
        player:gotoZone(xi.zone.EAST_RONFAURE)

        player:getStatusEffect(xi.effect.DEDICATION):setSubPower(1200)
        xi.test.world:skipTime(600)
        player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)

        local dedication = player:getStatusEffect(xi.effect.DEDICATION)
        assert(dedication ~= nil, 'Dedication should survive zoning')
        assert(dedication:getSubPower() == 1200,
            'expected the spent cap to persist, got ' .. tostring(dedication:getSubPower()))
    end)
end)
