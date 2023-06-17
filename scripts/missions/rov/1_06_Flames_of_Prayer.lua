-----------------------------------
-- Flames of Prayer
-- Rhapsodies of Vana'diel Mission 1-6
-----------------------------------
-- !addmission 13 10
-- Oaken Door : !pos 97 -7 -12 252
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.FLAMES_OF_PRAYER)

mission.reward =
{
    keyItem     = xi.ki.RHAPSODY_IN_WHITE,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_PATH_UNTRAVELED },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['_700'] =
            {
                onTrigger = function(player, npc)
                    local isRank3 = player:getRank(player:getNation()) >= 3 and 1 or 0

                    return mission:event(277, { [7] = isRank3 }):setPriority(1005)
                end,
            },

            onEventFinish =
            {
                [277] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
