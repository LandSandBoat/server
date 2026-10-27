describe('ASA M11 - Romancing the Clone', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 75 })

        -- Skips the Rhapsodies of Vana'diel cutscene on entering a city.
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONANCE)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.ROMANCING_THE_CLONE)
    end)

    it('plays the fountain scene once', function()
        player:gotoZone(xi.zone.FULL_MOON_FOUNTAIN)
        player.events:expect({ eventId = 64 })

        player:gotoZone(xi.zone.TORAIMARAI_CANAL)
        player:gotoZone(xi.zone.FULL_MOON_FOUNTAIN)
        player.events:expectNotInEvent()
    end)

    it('completes after talking to Aldo', function()
        player:gotoZone(xi.zone.LOWER_JEUNO)
        if player:isInEvent() then
            player.events:finish()
        end

        player.entities:gotoAndTrigger('Aldo', { eventId = 10101 })

        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.SISTERS_IN_ARMS)
    end)
end)
