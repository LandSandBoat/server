-----------------------------------
-- President Salaheem
-- Aht Uhrgan Mission 3
-----------------------------------
-- !addmission 4 2
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------
require('scripts/settings/main')
require("scripts/globals/besieged")
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PRESIDENT_SALAHEEM)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.KNIGHT_OF_GOLD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then
                        return mission:progressEvent(73, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                    elseif missionStatus == 2 and not mission:getMustZone(player) then
                        return mission:progressEvent(3020, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                    else
                        return mission:event(3003, xi.besieged.getMercenaryRank(player), 0, 0, 0, 0, 0, 0, 0, 0) -- Default Dialog.
                    end
                end,
            },

            ['Rytaal'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(269, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [73] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    mission:setMustZone(player)
                end,

                [269] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [3020] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
