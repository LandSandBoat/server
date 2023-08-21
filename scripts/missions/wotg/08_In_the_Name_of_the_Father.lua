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
require('scripts/missions/wotg/helpers')
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
                xi.wotg.helpers.meetsMission8Reqs(player)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] =
            {
                onTrigger = function(player, npc)
                    -- TODO     : What are these args from caps?
                    -- Observed : 1, 100, 0, 0, 0, 0, 0, 0 (San d'Oria, DNC Main)
                    return mission:progressEvent(85, player:getCampaignAllegiance(), 13, 0, 1, 3, 4, 8, 3)
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
