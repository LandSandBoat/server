-----------------------------------
-- A Sanguinary Prelude
-- Wings of the Goddess Mission 22
-----------------------------------
-- !addmission 5 21
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.A_SANGUINARY_PRELUDE)

mission.reward =
{
    keyItem     = xi.ki.AROMA_BUG,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.DUNGEONS_AND_DANCERS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BEAUCEDINE_GLACIER_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 17
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
