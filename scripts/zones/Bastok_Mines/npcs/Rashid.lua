-----------------------------------
-- Area: Bastok Mines
--  NPC: Rashid
-- Type: Mission Giver
-- !pos -8.444 -2 -123.575 234
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    local CurrentMission = player:getCurrentMission(BASTOK)
    local Count = trade:getItemCount()

    if (CurrentMission ~= tpz.mission.id.bastok.NONE) then
        if (CurrentMission == tpz.mission.id.bastok.FETICHISM and player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.FETICHISM) == false and trade:hasItemQty(606, 1) and trade:hasItemQty(607, 1) and trade:hasItemQty(608, 1) and trade:hasItemQty(609, 1) and Count == 4) then
            player:startEvent(1008) -- Finish Mission "Fetichism" (First Time)
        elseif (CurrentMission == tpz.mission.id.bastok.FETICHISM and trade:hasItemQty(606, 1) and trade:hasItemQty(607, 1) and trade:hasItemQty(608, 1) and trade:hasItemQty(609, 1) and Count == 4) then
            player:startEvent(1005) -- Finish Mission "Fetichism" (Repeat)
        elseif (CurrentMission == tpz.mission.id.bastok.TO_THE_FORSAKEN_MINES and player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.TO_THE_FORSAKEN_MINES) == false and trade:hasItemQty(563, 1) and Count == 1) then
            player:startEvent(1010) -- Finish Mission "To the forsaken mines" (First Time)
        elseif (CurrentMission == tpz.mission.id.bastok.TO_THE_FORSAKEN_MINES and trade:hasItemQty(563, 1) and Count == 1) then
            player:startEvent(1006) -- Finish Mission "To the forsaken mines" (Repeat)
        end
    end

end

function onTrigger(player, npc)

    if (player:getNation() ~= tpz.nation.BASTOK) then
        player:startEvent(1003) -- For non-Bastokian
    else
        local CurrentMission = player:getCurrentMission(BASTOK)
        local cs, p, offset = getMissionOffset(player, 1, CurrentMission, player:getCharVar("MissionStatus"))

        if (cs ~= 0 or offset ~= 0 or ((CurrentMission == tpz.mission.id.bastok.THE_ZERUHN_REPORT or
                                        CurrentMission == tpz.mission.id.bastok.RETURN_OF_THE_TALEKEEPER) and offset == 0)) then
            if (CurrentMission <= tpz.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS and cs == 0) then
                player:showText(npc, ID.text.ORIGINAL_MISSION_OFFSET + offset) -- dialog after accepting mission (Rank 1~5)
            elseif (CurrentMission > tpz.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS and cs == 0) then
                player:showText(npc, ID.text.EXTENDED_MISSION_OFFSET + offset) -- dialog after accepting mission (Rank 6~10)
            else
                player:startEvent(cs, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8])
            end
        elseif (player:getRank() == 1 and player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_ZERUHN_REPORT) == false) then
            player:startEvent(1000) -- Start First Mission "The Zeruhn Report"
        elseif (CurrentMission ~= tpz.mission.id.bastok.NONE) then
            player:startEvent(1002) -- Have mission already activated
        else
            local flagMission, repeatMission = getMissionMask(player)
            player:startEvent(1001, flagMission, 0, 0, 0, 0, repeatMission) -- Mission List
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    finishMissionTimeline(player, 1, csid, option)

end
