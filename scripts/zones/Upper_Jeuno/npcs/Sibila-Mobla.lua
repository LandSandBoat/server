-----------------------------------
-- Area: Upper Jeuno
--  NPC: Sibila-Mobla
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno, 5) == false) then
        player:startEvent(10083)
    else
        player:startEvent(98)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10083) then
        player:setMaskBit(player:getCharVar("WildcatJeuno"), "WildcatJeuno", 5, true)
    end
end
