-----------------------------------
-- Call of the Void
-- Rhapsodies of Vana'diel Mission 2-38
-----------------------------------
-- !addmission 13 132

-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.CALL_OF_THE_VOID)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.BOTH_PATHS_TAKEN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Dimensional_Portal'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(44)
                end,
            },

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    player:setPos(540, 0, -514, 63, xi.zone.EMPYREAL_PARADOX)
                end,
            },
        },

        [xi.zone.EMPYREAL_PARADOX] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 9
                end,
            },

            onEventUpdate =
            {
                [9] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(1, 10, 196, 320, 196, 196, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
