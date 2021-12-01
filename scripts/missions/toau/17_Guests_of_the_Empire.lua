-----------------------------------
-- Guests of the Empire
-- Aht Uhrgan Mission 17
-----------------------------------
-- !addmission 4 16
-- Naja Salaheem      : !pos 22.700 -8.804 -45.591 50
-- Imperial Whitegate : !pos 152 -2 0 50
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

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.GUESTS_OF_THE_EMPIRE)

mission.reward =
{
    item        = xi.items.IMPERIAL_MYTHRIL_PIECE,
    title       = xi.title.OVJANGS_ERRAND_RUNNER,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.PASSING_GLORY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        player:getEquipID(xi.slot.MAIN) == 0 and
                        player:getEquipID(xi.slot.SUB) == 0 and
                        whitegateShared.doRoyalPalaceArmorCheck(player)
                    then
                        return mission:progressEvent(3078, 0, 1, 0, 0, 0, 0, 0, 1, 0)
                    end
                end,
            },

            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    local eventId = player:getMissionStatus(mission.areaId) == 0 and 3076 or 3077

                    if whitegateShared.doRoyalPalaceArmorCheck(player) then
                        return mission:progressEvent(eventId, 1, 0, 0, 0, 0, 0, 0, 1, 0)
                    else
                        return mission:progressEvent(eventId, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [3076] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,

                [3078] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setLocalVar('Mission[4][17]mustZone', 1)
                        player:setCharVar('Mission[4][17]Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
