-----------------------------------
-- Area: Port Jeuno
--  NPC: Rinzei
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatJeuno = player:getCharVar("WildcatJeuno")

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno, 18) == false) then
        player:startEvent(315)
    else
        player:startEvent(56)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 315) then
        player:setMaskBit(player:getCharVar("WildcatJeuno"), "WildcatJeuno", 18, true)
    end
end
