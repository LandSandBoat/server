-----------------------------------
-- Guests of the Empire
-- Aht Uhrgan Mission 17
-----------------------------------
-- !addmission 4 16
-- Naja Salaheem      : !pos 22.700 -8.804 -45.591 50
-- Imperial Whitegate : !pos 152 -2 0 50
-----------------------------------
local whitegateShared = require('scripts/zones/Aht_Urhgan_Whitegate/Shared')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.GUESTS_OF_THE_EMPIRE)

mission.reward =
{
    item        = xi.item.IMPERIAL_MYTHRIL_PIECE,
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
                    else
                        return mission:event(3081, 0, 2, 1, 0, 1, 0, 1, 0, 0)
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
                        return mission:progressEvent(eventId, { text_table = 0 })
                    end
                end,
            },

            onEventUpdate =
            {
                [3076] = function(player, csid, option, npc)
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
                [3076] = function(player, csid, option, npc)
                    mission:setLocalVar(player, 'najaDressUp', 0)
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
