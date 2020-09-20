-----------------------------------
-- Area: Upper Jeuno
--  NPC: Hinda
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno, 9) == false) then
        player:startEvent(10087)
    else
        player:startEvent(161)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10087) then
        player:setMaskBit(player:getCharVar("WildcatJeuno"), "WildcatJeuno", 9, true)
    end
end
