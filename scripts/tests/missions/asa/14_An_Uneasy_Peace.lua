describe('ASA M14 - An Uneasy Peace', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 75 })

        -- Skips the Rhapsodies of Vana'diel cutscene on entering a city.
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONANCE)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE)
    end)

    it('plays the chamber scene once', function()
        player:gotoZone(xi.zone.SACRIFICIAL_CHAMBER)
        player.events:expect({ eventId = 5 })

        player:gotoZone(xi.zone.TEMPLE_OF_UGGALEPIH)
        player:gotoZone(xi.zone.SACRIFICIAL_CHAMBER)
        player.events:expectNotInEvent()
    end)

    it('completes on entering Windurst Walls from the Woods with the Behemoth key', function()
        player:gotoZone(xi.zone.WINDURST_WOODS)
        if player:isInEvent() then
            player.events:finish()
        end

        player:gotoZone(xi.zone.WINDURST_WALLS)
        player.events:expect({ eventId = 511 })

        player.assert:hasKI(xi.keyItem.BEHEMOTH_KEY)
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN)
    end)

    it('waits when Windurst Walls is entered from elsewhere', function()
        player:gotoZone(xi.zone.WINDURST_WALLS)

        player.events:expectNotInEvent()
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE)
    end)
end)
