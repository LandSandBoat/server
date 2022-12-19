-----------------------------------
-- A Fate Decided
-- Promathia 8-2
-----------------------------------
-- !addmission 6 818
-- Particle Gate : !pos 1 0.1 -320 34
-- Cermet portal : !pos 420 0 401 34
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/missions')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GRAND_PALACE_OF_HUXZOI] =
        {
            ['_iyq'] =
            {
                onTrigger = function(player, npc)
                    if
                        mission:getVar(player, 'Status') == 0 and
                        not GetMobByID(ID.mob.IXGHRAH):isSpawned()
                    then
                        SpawnMob(ID.mob.IXGHRAH):updateClaim(player)
                    elseif mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(3)
                    end
                end,
            },

            ['Ixghrah'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getVar(player, 'Status') == 0 then
                        mission:setVar(player, 'Status', 1)
                    end
                end
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        mission:complete(player)
                    end
                end,
            },
        }
    }
}

return mission
