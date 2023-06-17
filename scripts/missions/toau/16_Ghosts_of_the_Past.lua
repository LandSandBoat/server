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
                    -- NOTE: In captures, parameter 2 is 1 and 8 is 0. This means we don't know what this args actually do nor where they come from.
                    -- I could not notice any difference.
                    if whitegateShared.doRoyalPalaceArmorCheck(player) then
                        return mission:progressEvent(3074, 1, 0, 0, 0, 0, 0, 0, 1, 0)
                    else
                        return mission:progressEvent(3074, { text_table = 0 })
                    end
                end,
            },

            onEventUpdate =
            {
                [3074] = function(player, csid, option, npc)
                    local paramOne = mission:getLocalVar(player, 'najaDressUp')

                    if option == 1 then -- Initial, before playing dress-up with Naja.
                        player:updateEvent(50, 1, 0, 0, 0, 1, 0, 0, 0)

                    -- First argument disables options. Others do seem to affect whatever Naja is wearing.
                    elseif option == 10 then -- Blue with Gold trimming.
                        paramOne = utils.mask.setBit(paramOne, 1, true)
                        player:updateEvent(paramOne, 1, 255, 0, 0, 0, 4095, 0, 0)
                    elseif option == 11 then -- Red with gold embroidery.
                        paramOne = utils.mask.setBit(paramOne, 2, true)
                        player:updateEvent(paramOne, 1, 1757, 0, 0, 0, 4095, 1, 0)
                    elseif option == 12 then -- Pale colors with lace.
                        paramOne = utils.mask.setBit(paramOne, 3, true)
                        player:updateEvent(paramOne, 1, 10, 0, 1, 1, 0, 0, 0)
                    elseif option == 13 then -- Deep purple armor.
                        paramOne = utils.mask.setBit(paramOne, 4, true)
                        player:updateEvent(paramOne, 1, 0, 0, 0, 0, 0, 0, 0)
                    elseif option == 14 then -- Rich crimson!
                        paramOne = utils.mask.setBit(paramOne, 5, true)
                        player:updateEvent(paramOne, 1, 0, 0, 0, 1, 32, 1, 0)
                    elseif option == 15 then -- Cloth with a pattern.
                        paramOne = utils.mask.setBit(paramOne, 6, true)
                        player:updateEvent(paramOne, 1, 2964, 0, 0, 2185, 3, 0, 0)
                    elseif option == 16 then -- Indigo with gold embroidery.
                        paramOne = utils.mask.setBit(paramOne, 7, true)
                        player:updateEvent(paramOne, 1, 1, 22185, 0, 1, 0, 0, 0)
                    elseif option == 17 then -- Georgeous black.
                        paramOne = utils.mask.setBit(paramOne, 8, true)
                        player:updateEvent(paramOne, 1, 1320, 0, 0, 1, 1, 1, 0, 0)
                    end

                    mission:setLocalVar(player, 'najaDressUp', paramOne)
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
