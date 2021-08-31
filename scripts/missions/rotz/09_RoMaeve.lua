-----------------------------------
-- Ro'Maeve
-- Zilart M9
-----------------------------------
-- !addmission 3 18
-- _700 (Oaken Door) : !pos 97 -7 -12 252
-- Aldo              : !pos 20 3 -58 245
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.ROMAEVE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION },
}

mission.sections =
{
    -- Section: Mission Active
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['_700']  = mission:progressEvent(3),

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setMissionStatus(xi.mission.log_id.ZILART, 0)
                        mission:complete(player)
                    end
                end,
            },
        },
    },

    -- Section: Mission Active and missionStatus == 0, Rank >= 5 (For current nation)
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0 and player:getRank(player:getNation()) >= 5
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] = mission:event(84),

            onEventFinish =
            {
                [84] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 1)
                end,
            },
        },
    },
}

return mission
