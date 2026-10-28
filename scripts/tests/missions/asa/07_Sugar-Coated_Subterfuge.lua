describe('ASA M7 - Sugar-Coated Subterfuge', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 75 })

        -- Skips the Rhapsodies of Vana'diel cutscene on entering a city.
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONANCE)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_SUBTERFUGE)
    end)

    it('completes after talking to Aldo', function()
        player:gotoZone(xi.zone.LOWER_JEUNO)
        if player:isInEvent() then
            player.events:finish()
        end

        player.entities:gotoAndTrigger('Aldo', { eventId = 10100 })

        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.SHANTOTTO_IN_CHAINS)
    end)
end)
