-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Yavoraile
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 4)) then
        player:startEvent(10092)
    else
        player:startEvent(118)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10092) then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 4, true))
    end
end
