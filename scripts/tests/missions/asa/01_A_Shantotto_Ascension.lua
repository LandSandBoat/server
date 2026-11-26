describe('ASA M1 - A Shantotto Ascension', function()
    ---@type CClientEntityPair
    local player

    local function enterWindurstWalls(level)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WINDURST_WOODS, level = level })

        -- Skips the Rhapsodies of Vana'diel cutscene on entering a city.
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONANCE)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION)
        if player:isInEvent() then
            player.events:finish()
        end

        player:gotoZone(xi.zone.WINDURST_WALLS)
    end

    it('starts on entering Windurst Walls from the Woods at level 10', function()
        enterWindurstWalls(10)

        player.events:expect({ eventId = 510 })
        player.events:expect({ eventId = 514 })
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
    end)

    it('does not start below level 10', function()
        enterWindurstWalls(9)

        player.events:expectNotInEvent()
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION)
    end)
end)
