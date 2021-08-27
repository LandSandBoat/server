-----------------------------------
-- Through the Quicksand Caves
-- Zilart M6
-----------------------------------
-- !addmission 3 12
-- Shimmering Circle : !pos -220 0 12 168
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHAMBER_OF_ORACLES] = {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar("battlefieldWin") == 192 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
