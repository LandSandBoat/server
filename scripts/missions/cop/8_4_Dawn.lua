-----------------------------------
-- Dawn
-- Promathia 8-4
-----------------------------------
-- !addmission 6 840
-- Crystalline Field (H-11 Al'Taieu)
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require("scripts/globals/teleports")
require('scripts/globals/titles')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)

mission.reward =
{
    title = xi.title.BANISHER_OF_EMPTINESS,
    nextMission = xi.mission.id.cop.DAWN,
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ALTAIEU] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                print(mission:getVar(player, 'Status'))
                if mission:getVar(player, 'Status') < 1 then
                        return 167
                    end
                end,
            },

            onEventFinish =
            {
                [167] = function(player, csid, option)
                    mission:setVar(player, 'Status', 1)
                    player:delKeyItem(xi.ki.MYSTERIOUS_AMULET_PRISHE)
                    return player:messageSpecial(zones[player:getZoneID()].text.RETURN_AMULET_TO_PRISHE, xi.ki.MYSTERIOUS_AMULET)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end

    },
}

return mission
