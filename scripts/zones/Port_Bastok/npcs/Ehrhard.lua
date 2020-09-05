-----------------------------------
-- Area: Port Bastok
--  NPC: Ehrhard
-- Involved in Quest: Stamp Hunt
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local StampHunt = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STAMP_HUNT)

    if (StampHunt == QUEST_ACCEPTED and player:getMaskBit(player:getCharVar("StampHunt_Mask"), 5) == false) then
        player:startEvent(121)
    else
        player:startEvent(47)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 121) then
        player:setMaskBit(player:getCharVar("StampHunt_Mask"), "StampHunt_Mask", 5, true)
    end

end
