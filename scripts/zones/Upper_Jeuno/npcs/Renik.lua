-----------------------------------
-- Area: Upper Jeuno
--  NPC: Renik
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno, 8) == false) then
        player:startEvent(10086)
    else
        player:startEvent(168)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10086) then
        player:setMaskBit(player:getCharVar("WildcatJeuno"), "WildcatJeuno", 8, true)
    end
end
