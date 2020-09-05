-----------------------------------
-- Area: Bastok Mines
--  NPC: Deadly Spider
-- Involved in Quest: Stamp Hunt
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local StampHunt = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STAMP_HUNT)

    if (StampHunt == QUEST_ACCEPTED and player:getMaskBit(player:getCharVar("StampHunt_Mask"), 0) == false) then
        player:startEvent(86)
    else
        player:startEvent(17)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 86) then
        player:setMaskBit(player:getCharVar("StampHunt_Mask"), "StampHunt_Mask", 0, true)
    end

end
