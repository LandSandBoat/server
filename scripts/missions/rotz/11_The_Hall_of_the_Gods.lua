-----------------------------------
-- The Hall of the Gods
-- Zilart M11
-----------------------------------
-- !addmission 3 22
-- _700 (Oaken Door) : !pos 97 -7 -12 252
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local hallID = require('scripts/zones/Hall_of_the_Gods/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_HALL_OF_THE_GODS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HALL_OF_THE_GODS] =
        {
            ['_6z0'] = mission:messageSpecial(hallID.text.DEPRESSION_A_CLUE),
        },

        [xi.zone.NORG] =
        {
            ['_700'] = mission:progressEvent(169),

            onEventFinish =
            {
                [169] = function(player, csid, option, npc)
                    if option == 0 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
