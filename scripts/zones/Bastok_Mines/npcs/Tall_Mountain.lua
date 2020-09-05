-----------------------------------
-- Area: Bastok Mines
--  NPC: Tall Mountain
-- Involved in Quest: Stamp Hunt
-- Finish Mission: Bastok 6-1
-- !pos 71 7 -7 234
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local StampHunt = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STAMP_HUNT)

    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.RETURN_OF_THE_TALEKEEPER and player:getCharVar("MissionStatus") == 3) then
        player:startEvent(182)
    elseif (StampHunt == QUEST_ACCEPTED and player:getMaskBit(player:getCharVar("StampHunt_Mask"), 1) == false) then
        player:startEvent(85)
    else
        player:startEvent(55)
    end

end

-- 32693  55  85  176  180  182  591  593
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 182) then
        finishMissionTimeline(player, 1, csid, option)
    elseif (csid == 85) then
        player:setMaskBit(player:getCharVar("StampHunt_Mask"), "StampHunt_Mask", 1, true)
    end

end
