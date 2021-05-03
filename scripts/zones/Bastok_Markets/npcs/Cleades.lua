-----------------------------------
-- Area: Bastok Markets
--  NPC: Cleades
-- Type: Mission Giver
-- !pos -358 -10 -168 235
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Bastok_Markets/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    local currentMission = player:getCurrentMission(BASTOK)
    local Count = trade:getItemCount()

    if (currentMission ~= xi.mission.id.bastok.NONE) then
        if (currentMission == xi.mission.id.bastok.FETICHISM and player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM) == false and trade:hasItemQty(606, 1) and trade:hasItemQty(607, 1) and trade:hasItemQty(608, 1) and trade:hasItemQty(609, 1) and Count == 4) then
            player:startEvent(1008) -- Finish Mission "Fetichism" (First Time)
        elseif (currentMission == xi.mission.id.bastok.FETICHISM and trade:hasItemQty(606, 1) and trade:hasItemQty(607, 1) and trade:hasItemQty(608, 1) and trade:hasItemQty(609, 1) and Count == 4) then
            player:startEvent(1005) -- Finish Mission "Fetichism" (Repeat)
        elseif (currentMission == xi.mission.id.bastok.TO_THE_FORSAKEN_MINES and player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.TO_THE_FORSAKEN_MINES) == false and trade:hasItemQty(563, 1) and Count == 1) then
            player:startEvent(1010) -- Finish Mission "To the forsaken mines" (First Time)
        elseif (currentMission == xi.mission.id.bastok.TO_THE_FORSAKEN_MINES and trade:hasItemQty(563, 1) and Count == 1) then
            player:startEvent(1006) -- Finish Mission "To the forsaken mines" (Repeat)
        end
    end

end

entity.onTrigger = function(player, npc)

    if (player:getNation() ~= xi.nation.BASTOK) then
        player:startEvent(1003) -- For non-Bastokian
    else
        local currentMission = player:getCurrentMission(BASTOK)
        local cs, p, offset = getMissionOffset(player, 1, currentMission, player:getMissionStatus(player:getNation()))

        if (cs ~= 0 or offset ~= 0 or ((currentMission == xi.mission.id.bastok.THE_ZERUHN_REPORT or
                                        currentMission == xi.mission.id.bastok.RETURN_OF_THE_TALEKEEPER) and offset == 0)) then
            if (currentMission <= xi.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS and cs == 0) then
                player:showText(npc, ID.text.ORIGINAL_MISSION_OFFSET + offset) -- dialog after accepting mission (Rank 1~5)
            elseif (currentMission > xi.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS and cs == 0) then
                player:showText(npc, ID.text.EXTENDED_MISSION_OFFSET + offset) -- dialog after accepting mission (Rank 6~10)
            else
                player:startEvent(cs, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8])
            end
        elseif (player:getRank() == 1 and player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT) == false) then
            player:startEvent(1000) -- Start First Mission "The Zeruhn Report"
        elseif (currentMission ~= xi.mission.id.bastok.NONE) then
            player:startEvent(1002) -- Have mission already activated
        else
            local flagMission, repeatMission = getMissionMask(player)
            player:startEvent(1001, flagMission, 0, 0, 0, 0, repeatMission) -- Mission List
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    finishMissionTimeline(player, 1, csid, option)

end

return entity
