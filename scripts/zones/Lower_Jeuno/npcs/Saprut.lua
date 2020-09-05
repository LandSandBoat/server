-----------------------------------
-- Area: Lower Jeuno
--  NPC: Saprut
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatJeuno = player:getCharVar("WildcatJeuno")

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno, 11) == false) then
        player:startEvent(10054)
    else
        player:startEvent(224)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10054) then
        player:setMaskBit(player:getCharVar("WildcatJeuno"), "WildcatJeuno", 11, true)
    end
end
