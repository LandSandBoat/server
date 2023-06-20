-----------------------------------
-- Path of Blood
-- Aht Uhrgan Mission 37
-----------------------------------
-- !addmission 4 36
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PATH_OF_BLOOD)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.STIRRINGS_OF_WAR },
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
                    -- Event 3131 will automatically move the player to the end point
                    player:startEvent(3131)
                    return mission:progressEvent(3220)
                end,
            },

            onEventFinish =
            {
                [3220] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setLocalVar('Mission[4][37]mustZone', 1)
                        player:setCharVar('Mission[4][37]Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
