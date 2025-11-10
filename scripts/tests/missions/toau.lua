describe('Treasures of Aht Urhgan', function()
    ---@type CClientEntityPair
    local player

    --
    -- Positions
    --

    local approachingNajasDeskPos = { x = 34.7, y = -6.6, z = -54.1, rot = 237 }

    --
    -- Helpers
    --

    local gotoPositionAndTriggerArea = function(playerArg, position, triggerAreaId)
        playerArg:setPos(position)
        xi.test.world:tick(xi.tick.TRIGGER_AREAS)
        assert(playerArg:isPlayerInTriggerArea(triggerAreaId))
    end

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
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ABOMINATION)
    end)

    --
    -- Missions
    --

    describe('01 - Land of Sacred Serpents', function()
        it("should trigger the introduction cutscene at Salaheem's Sentinels and give Supplies Package key item", function()
            player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LAND_OF_SACRED_SERPENTS)
            player:addKeyItem(xi.ki.BOARDING_PERMIT)

            player:gotoZone(xi.zone.AHT_URHGAN_WHITEGATE)
            assert(not player:isPlayerInTriggerArea(3))

            gotoPositionAndTriggerArea(player, approachingNajasDeskPos, 3)
            player.events:expect({ eventId = 3000, finishOption = 0 })

            player.assert:hasMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IMMORTAL_SENTRIES)
            player.assert:hasKI(xi.ki.SUPPLIES_PACKAGE)
        end)
    end)
end)
