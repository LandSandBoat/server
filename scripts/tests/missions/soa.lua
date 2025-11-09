describe('Seekers of Adoulin', function()
    ---@type CClientEntityPair
    local player

    --
    -- Setup
    --

    before_each(function()
        player = xi.test.world:spawnPlayer()
        player:setLevel(99)

        -- Mission conflicts
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.A_RHAPSODY_FOR_THE_AGES)
    end)

    --
    -- Missions
    --

    describe('1-1 - Rumors from the West', function()
        it('Start Geomagnetron route', function()
            player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST)

            player:gotoZone(xi.zone.LOWER_JEUNO)
            player.entities:gotoAndTrigger('Darcia', { eventId = 10117, finishOption = 1 })

            player.assert:hasMission(xi.mission.log_id.SOA, xi.mission.id.soa.THE_GEOMAGNETRON)
            player.assert:hasKI(xi.ki.GEOMAGNETRON)
        end)

        it('Paid route (skip Geomagnetron)', function()
            player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST)

            player:gotoZone(xi.zone.LOWER_JEUNO)
            player:addGil(1000000)
            player.entities:gotoAndTrigger('Darcia', { eventId = 10117, finishOption = 2 })

            -- This should have cost the player 1,000,000 gil
            assert(player:getGil() == 0)

            player.assert:hasCompletedMission(xi.mission.log_id.SOA, xi.mission.id.soa.THE_GEOMAGNETRON)
            player.assert:hasMission(xi.mission.log_id.SOA, xi.mission.id.soa.ONWARD_TO_ADOULIN)
            player.assert:hasKI(xi.ki.ADOULINIAN_CHARTER_PERMIT)
        end)
    end)
end)
