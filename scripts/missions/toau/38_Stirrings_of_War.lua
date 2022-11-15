-----------------------------------
-- Stirrings of War
-- Aht Uhrgan Mission 38
-----------------------------------
-- !addmission 4 37
-----------------------------------
require("scripts/globals/besieged")
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.STIRRINGS_OF_WAR)

mission.reward =
{
    keyItem     = xi.ki.ALLIED_COUNCIL_SUMMONS,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.ALLIED_RUMBLINGS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                not mission:getMustZone(player) and
                VanadielUniqueDay() >= mission:getVar(player, 'Timer')
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [5] = function(player, triggerArea)
                    return mission:progressEvent(3136, { text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [3136] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
