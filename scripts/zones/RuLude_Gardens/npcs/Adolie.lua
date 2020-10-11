-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Adolie
-- !pos -35 2 59 243
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 3)) then
        player:startEvent(10091)
    else
        player:startEvent(30) -- Standard dialog
    end
end

-- 24  30  31  32  158  98  157  97  100  10091
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10091) then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 3, true))
    end
end
