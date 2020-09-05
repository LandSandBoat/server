-----------------------------------
-- Area: Port Bastok
--  NPC: Latifah
-- Involved in Quest: Stamp Hunt
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local StampHunt = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STAMP_HUNT)

    if (StampHunt == QUEST_ACCEPTED and player:getMaskBit(player:getCharVar("StampHunt_Mask"), 6) == false) then
        player:startEvent(120)
    else
        player:startEvent(13)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 120) then
        player:setMaskBit(player:getCharVar("StampHunt_Mask"), "StampHunt_Mask", 6, true)
    end

end
