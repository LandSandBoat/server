-----------------------------------
-- The Celestial Nexus
-- Zilart M16
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING },
    title = xi.title.BURIER_OF_THE_ILLUSION,
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] = mission:event(173),
        },

        [xi.zone.THE_CELESTIAL_NEXUS] = {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar("battlefieldWin") == 320 then
                        mission:complete()
                    end
                    player:setPos(0, -18, 137, 64, 251) -- Hall of the Gods
                end,
            },
        },
    },
}

return mission
