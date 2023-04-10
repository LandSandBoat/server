-----------------------------------
-- Bastion of Knowledge
-- Aht Uhrgan Mission 28
-----------------------------------
-- !addmission 4 27
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.BASTION_OF_KNOWLEDGE)

mission.reward =
{
    title       = xi.title.APHMAUS_MERCENARY,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.PUPPET_IN_PERIL },
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
                [4] = function(player, triggerArea)
                    return mission:progressEvent(3112)
                end,
            },

            onEventFinish =
            {
                [3112] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
