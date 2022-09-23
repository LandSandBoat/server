-----------------------------------
-- A Spoonful of Sugar
-- Wings of the Goddess Mission 11
-----------------------------------
-- !addmission 5 10
-- Raustigne : !pos 3.979 -1.999 44.456 80
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.A_SPOONFUL_OF_SUGAR)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.AFFAIRS_OF_STATE },
}

mission.sections =
{
    -- 0: Talk to Raustigne
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Raustigne'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: What are these args from caps?
                    return mission:progressEvent(87, 2, 7, 0, 0, 0, 0, 3, 4095)
                end,
            },

            onEventFinish =
            {
                [87] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
