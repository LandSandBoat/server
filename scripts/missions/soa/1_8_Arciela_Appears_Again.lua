-----------------------------------
-- Arciela Appears Again
-- Seekers of Adoulin M1-8
-----------------------------------
-- !addmission 12 9
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.ARCIELA_APPEARS_AGAIN)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.BUDDING_PROSPECTS },
}

local spentEnoughImprimaturs = function(player)
    -- TODO: All of this
    local imprimatursSpent = 0
    local fame = player:getFameLevel(ADOULIN)
    local gate = 100 - (fame * 10)
    return imprimatursSpent >= gate
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   spentEnoughImprimaturs(player)
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)
                    if missionStatus == 0 then
                        return mission:progressEvent(6)
                    else
                        return mission:progressEvent(7)
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:complete(player)
                    else
                        player:setMissionStatus(mission.areaId, 1)
                    end
                    player:setMissionStatus(mission.areaId, 1)
                    mission:complete(player)
                end,

                [7] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
