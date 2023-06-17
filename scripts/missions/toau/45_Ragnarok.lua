-----------------------------------
-- Ragnarok
-- Aht Uhrgan Mission 45
-----------------------------------
-- !addmission 4 44
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.RAGNAROK)

mission.reward =
{
    title       = xi.title.NASHMEIRAS_LOYALIST,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.IMPERIAL_CORONATION },
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
                    return mission:progressEvent(3139, { text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [3139] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
