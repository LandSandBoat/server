-----------------------------------
-- Ghosts of the Past
-- Aht Uhrgan Mission 16
-----------------------------------
-- !addmission 4 15
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------
require("scripts/globals/besieged")
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local whitegateShared = require("scripts/zones/Aht_Urhgan_Whitegate/Shared")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.GHOSTS_OF_THE_PAST)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.GUESTS_OF_THE_EMPIRE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if whitegateShared.doRoyalPalaceArmorCheck(player) then
                        return mission:progressEvent(3074, 1, 0, 0, 0, 0, 0, 0, 1, 0)
                    else
                        return mission:progressEvent(3074, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [3074] = function(player, csid, option, npc)
                    mission:complete(player)

                    if option == 2 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },
    },
}

return mission
