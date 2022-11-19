-----------------------------------
-- Social Graces
-- Aht Uhrgan Mission 23
-----------------------------------
-- !addmission 4 22
-----------------------------------
require("scripts/globals/besieged")
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.SOCIAL_GRACES)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.FOILED_AMBITION },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    return mission:progressEvent(3095)
                end,
            },

            onEventFinish =
            {
                [3095] = function(player, csid, option, npc)
                    player:setLocalVar('Mission[4][23]mustZone', 1)
                    player:setCharVar('Mission[4][23]Timer', VanadielUniqueDay() + 1)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
