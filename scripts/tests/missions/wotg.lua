describe('Wings of the Goddess', function()
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
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ABOMINATION)
    end)

    --
    -- Missions
    --

    describe('01 - Cavernous Maws', function()
        local presentMawZones = {
            ['Batallia Downs']       = xi.zone.BATALLIA_DOWNS,
            ['Rolanberry Fields']    = xi.zone.ROLANBERRY_FIELDS,
            ['Sauromugue Champaign'] = xi.zone.SAUROMUGUE_CHAMPAIGN,
        }

        local pastMawZones = set{
            xi.zone.BATALLIA_DOWNS_S,
            xi.zone.ROLANBERRY_FIELDS_S,
            xi.zone.SAUROMUGUE_CHAMPAIGN_S,
        }

        local playerIsInPastMawZone = function()
            return pastMawZones[player:getZoneID()] ~= nil
        end

        local cavernousMawsMissionBody = function(zoneId)
            player:addMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.CAVERNOUS_MAWS)

            player:gotoZone(zoneId)
            player.entities:gotoAndTrigger('Cavernous_Maw', { eventId = 500 })

            player.assert:hasMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.BACK_TO_THE_BEGINNING)
            player.assert:hasKI(xi.ki.PURE_WHITE_FEATHER)
            assert(playerIsInPastMawZone())
        end

        for zoneName, zoneId in pairs(presentMawZones) do
            it(fmt('should trigger the Maw in {}, get the CS, and be sent to a random Maw zone in the past', zoneName), function()
                cavernousMawsMissionBody(zoneId)
            end)
        end
    end)
end)
