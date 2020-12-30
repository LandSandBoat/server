-----------------------------------
-- Area: Port Bastok
--  NPC: Ehrhard
-- Involved in Quest: Stamp Hunt
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local StampHunt = player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.STAMP_HUNT)

    if (StampHunt == QUEST_ACCEPTED and not utils.mask.getBit(player:getCharVar("StampHunt_Mask"), 5)) then
        player:startEvent(121)
    else
        player:startEvent(47)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 121) then
        player:setCharVar("StampHunt_Mask", utils.mask.setBit(player:getCharVar("StampHunt_Mask"), 5, true))
    end

end
