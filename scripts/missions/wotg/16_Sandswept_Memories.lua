-----------------------------------
-- Sandswept Memories
-- Wings of the Goddess Mission 16
-----------------------------------
-- !addmission 5 15
-- Lion Springs Door : !pos 96 0 106 80
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/maws')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/settings')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
require('scripts/missions/wotg/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.SANDSWEPT_MEMORIES)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.NORTHLAND_EXPOSURE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] = mission:progressEvent(146, 2, 0, 0, 0, 0, 0, 0, 4095),

            onEventFinish =
            {
                [146] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
