-----------------------------------
-- Sight aggro respects line of sight (no aggro around a corner)
--
-- A Groundskeeper sits in a slightly-raised alcove in RuAun Gardens. A player
-- standing in front of the alcove is in plain view and should be aggroed; a
-- player who steps around the corner is hidden by the wall and should not be,
-- even though the elevation and distance are nearly identical.
--
-- NOTE: We currently have a bug where these Groundskeepers do not have sight detection
--     : set, so, we're forcing it on for this test.
-----------------------------------

describe('Sight aggro line of sight', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.RUAUN_GARDENS })
    end)

    -- The alcove Groundskeeper, picked out of RuAun's ~100 Groundskeepers by its
    -- position rather than a brittle hardcoded entity id.
    local function alcoveGroundskeeper()
        local ax = 20.239
        local ay = -41.729
        local az = -340.048

        local best     = nil
        local bestDist = nil

        for _, e in ipairs(player:getZone():queryEntitiesByName('Groundskeeper')) do
            local dx   = e:getXPos() - ax
            local dy   = e:getYPos() - ay
            local dz   = e:getZPos() - az
            local dist = dx * dx + dy * dy + dz * dz
            if not bestDist or dist < bestDist then
                best     = e
                bestDist = dist
            end
        end

        return best
    end

    it('aggros in front of the alcove but not around the corner', function()
        local mob = alcoveGroundskeeper()
        assert(mob, 'alcove Groundskeeper not found')

        -- Roam past the post-spawn neutral window so the mob can aggro at all.
        for _ = 1, 10 do
            xi.test.world:skipTime(5)
            xi.test.world:tickEntity(mob)
        end

        -- Around the corner: within range and facing, but the wall blocks sight.
        mob:lookAt(12.5537, -40.241, -347.141)
        player.actions:move(12.5537, -40.241, -347.141, 30)
        assert(not mob:isEngaged(), 'mob should not aggro a player hidden around the corner')

        -- In front of the alcove: clear line of sight -> aggro.
        mob:lookAt(11.1005, -40.241, -340.042)
        player.actions:move(11.1005, -40.241, -340.042, 26)
        assert(mob:isEngaged(), 'mob should aggro a player in plain view in front of the alcove')
    end)
end)
