-----------------------------------
-- Imperial Coronation
-- Aht Uhrgan Mission 46
-----------------------------------
-- !addmission 4 45
-----------------------------------
local whitegateShared = require('scripts/zones/Aht_Urhgan_Whitegate/Shared')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.IMPERIAL_CORONATION)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.THE_EMPRESS_CROWNED },
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
                    local properlyDressed = whitegateShared.doRoyalPalaceArmorCheck(player) and 1 or 0

                    if
                        player:getEquipID(xi.slot.MAIN) == 0 and
                        player:getEquipID(xi.slot.SUB) == 0 and
                        properlyDressed == 1
                    then
                        return mission:progressEvent(3140, 0, player:getTitle(), 0, 0, 0, 0, 0, properlyDressed, 0)
                    else
                        return mission:event(3081, 0, 1, 0, 0, 0, 0, 0, 0, properlyDressed, 0)
                    end
                end,
            },

            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(3150, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventUpdate =
            {
                [3140] = function(player, csid, option, npc)
                    -- Reject all 3 rings.
                    if option == 0 then
                        player:updateEvent(0, 1, 0, 0, 0, 0, 0, 0, 0)

                    -- Chosen Balrahn's Ring.
                    elseif option == 1 then
                        if npcUtil.giveItem(player, xi.item.BALRAHNS_RING) then
                            player:updateEvent(1, 1, 0, 0, 0, 0, 0, 0, 0)
                            player:setCharVar('Mission[4][45]Ring', NextConquestTally(), NextConquestTally())
                        else
                            player:updateEvent(1, 1, 0, 0, 0, 0, 0, 0, 0)
                        end

                    -- Chosen Ulthalam's Ring.
                    elseif option == 2 then
                        if npcUtil.giveItem(player, xi.item.ULTHALAMS_RING) then
                            player:updateEvent(1, 1, 0, 0, 0, 0, 0, 0, 0)
                            player:setCharVar('Mission[4][45]Ring', NextConquestTally(), NextConquestTally())
                        end

                    -- Chosen Jalzahn's Ring.
                    elseif option == 3 then
                        if npcUtil.giveItem(player, xi.item.JALZAHNS_RING) then
                            player:updateEvent(1, 1, 0, 0, 0, 0, 0, 0, 0)
                            player:setCharVar('Mission[4][45]Ring', NextConquestTally(), NextConquestTally())
                        end

                    -- Get Imperial Standard.
                    elseif option == 4 then
                        if npcUtil.giveItem(player, xi.item.IMPERIAL_STANDARD) then
                            player:updateEvent(1, 1, 0, 0, 0, 0, 0, 0, 0)
                        else
                            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0, 0) -- TODO: Try with full inv.
                        end

                    -- Offered rings.
                    elseif option == 99 then
                        player:updateEvent(xi.item.BALRAHNS_RING, xi.item.ULTHALAMS_RING, xi.item.JALZAHNS_RING, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [3140] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    local properlyDressed = whitegateShared.doRoyalPalaceArmorCheck(player) and 1 or 0

                    if
                        player:getEquipID(xi.slot.MAIN) == 0 and
                        player:getEquipID(xi.slot.SUB) == 0 and
                        properlyDressed == 1
                    then
                        local hasImperialStandard = player:hasItem(xi.item.IMPERIAL_STANDARD) and 0 or 1
                        local hasScenarioRing     = player:getCharVar('Mission[4][45]Ring') ~= 0 and 0 or 1

                        return mission:event(3155, hasImperialStandard, hasScenarioRing, 0, 0, 0, 0, 0, properlyDressed, 0)
                    end
                end,
            },

            -- TODO: Nadeey npc ring-recovering event.

            onEventUpdate =
            {
                [3155] = function(player, csid, option, npc)
                    -- Reject all 3 rings
                    if option == 0 then
                        player:updateEvent(0, 1, 0, 0, 0, 0, 0, 0, 0)

                    -- Chosen Balrahn's Ring
                    elseif option == 1 then
                        if npcUtil.giveItem(player, xi.item.BALRAHNS_RING) then
                            player:updateEvent(1, 1, 0, 0, 0, 0, 0, 0, 0)
                            player:setCharVar('Mission[4][45]Ring', xi.item.BALRAHNS_RING)
                        else
                            player:updateEvent(1, 1, 0, 0, 0, 0, 0, 0, 0)
                        end

                    -- Chosen Ulthalam's Ring
                    elseif option == 2 then
                        if npcUtil.giveItem(player, xi.item.ULTHALAMS_RING) then
                            player:updateEvent(1, 1, 0, 0, 0, 0, 0, 0, 0)
                            player:setCharVar('Mission[4][45]Ring', xi.item.ULTHALAMS_RING)
                        end

                    -- Chosen Jalzahn's Ring.
                    elseif option == 3 then
                        if npcUtil.giveItem(player, xi.item.JALZAHNS_RING) then
                            player:updateEvent(1, 1, 0, 0, 0, 0, 0, 0, 0)
                            player:setCharVar('Mission[4][45]Ring', xi.item.JALZAHNS_RING)
                        end

                    -- Get Imperial Standard.
                    elseif option == 6 then
                        if npcUtil.giveItem(player, xi.item.IMPERIAL_STANDARD) then
                            player:updateEvent(1, 1, 0, 0, 0, 0, 0, 0, 0)
                        else
                            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0, 0) -- TODO: Try with full inv.
                        end

                    -- Offer rings.
                    elseif option == 99 then
                        player:updateEvent(xi.item.BALRAHNS_RING, xi.item.ULTHALAMS_RING, xi.item.JALZAHNS_RING, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },
        },
    },
}

return mission
