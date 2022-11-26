-----------------------------------
-- Testing the Waters
-- Aht Uhrgan Mission 34
-----------------------------------
-- !addmission 4 33
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.TESTING_THE_WATERS)

mission.reward =
{
    keyItem     = xi.ki.PERCIPIENT_EYE,
    title       = xi.title.TREASURE_TROVE_TENDER,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.LEGACY_OF_THE_LOST },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ARRAPAGO_REEF] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if player:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN) then
                        return mission:progressEvent(15)
                    end
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setMissionStatus(mission.areaId, 1)
                        player:setPos(-88.879, -7.318, -109.233, 173, 57)
                    end
                end,
            },
        },

        [xi.zone.TALACCA_COVE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 106
                    end
                end,
            },

            onEventFinish =
            {
                [106] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
                    end
                end,
            },
        },
    },
}

return mission
