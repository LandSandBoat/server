-----------------------------------
-- Area: North Gustaberg (S) (F-8)
--  NPC: ???
-- Involved in Quests
-- !pos -232 41 425
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.BETTER_PART_OF_VALOR) == QUEST_ACCEPTED and player:getCharVar("BetterPartOfValProg") == 1) then
        player:startEvent(3)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 3) then
        player:setCharVar("BetterPartOfValProg", 2)
    end
end
