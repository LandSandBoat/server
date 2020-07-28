-----------------------------------
-- Area: North Gustaberg (S) (I-6)
--  NPC: Gebhardt
-- Involved in Quests: The Fighting Fourth
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_FIGHTING_FOURTH) == QUEST_ACCEPTED and player:getCharVar("THE_FIGHTING_FOURTH") == 1) then
        player:startEvent(104)
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_FIGHTING_FOURTH) == QUEST_ACCEPTED and player:getCharVar("THE_FIGHTING_FOURTH") == 3) then
        player:startEvent(109)
    else
        player:startEvent(111)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 104) then
        player:setCharVar("THE_FIGHTING_FOURTH", 2)
    end
end
