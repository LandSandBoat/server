-----------------------------------
-- In the Name of the Father
-- Wings of the Goddess Mission 8
-----------------------------------
-- !addmission 5 7
-- FIRE_IN_THE_HOLE   : !completequest 7 36
-- IN_A_HAZE_OF_GLORY : !completequest 7 38
-- A_FEAST_FOR_GNATS  : !completequest 7 40
-- Lion Springs Door  : !pos 96 0 106 80
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/maws")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/interaction/mission")
require("scripts/globals/zone")
require("scripts/missions/wotg/helpers")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.IN_THE_NAME_OF_THE_FATHER)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.DANCERS_IN_DISTRESS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   xi.wotg.helpers.meetsMission3Reqs(player)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ["Lion_Springs"] =
            {
                onTrigger = function(player, npc)
                    -- TODO: What are these args from caps?
                    return mission:progressEvent(85, 2, 13, 0, 1, 3, 4, 8, 3)
                end,
            },

            onEventFinish =
            {
                [85] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
