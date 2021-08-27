-----------------------------------
-- Welcome t'Norg
-- Zilart M2
-----------------------------------
-- !addmission 3 4
-- _700 (Oaken Door) : !pos 97 -7 -12 252
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.WELCOME_TNORG)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.KAZHAMS_CHIEFTAINESS },
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
                    return mission:progressEvent(2)
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if option == 0 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
