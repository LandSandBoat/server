-----------------------------------
-- Allied Rumblings
-- Aht Uhrgan Mission 39
-----------------------------------
-- !addmission 4 38
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.ALLIED_RUMBLINGS)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.UNRAVELING_REASON },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return mission:progressEvent(10097)
                end,
            },

            onEventFinish =
            {
                [10097] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
