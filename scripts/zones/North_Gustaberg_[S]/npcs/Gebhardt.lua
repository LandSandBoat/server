-----------------------------------
-- Area: North Gustaberg (S) (I-6)
--  NPC: Gebhardt
-- Involved in Quests: The Fighting Fourth
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_FIGHTING_FOURTH) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.BATTLE_RATIONS)) == true then
        player:startEvent(102)
    else
        player:startEvent(110)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 102) then
            player:delKeyItem(tpz.ki.BATTLE_RATIONS)
            player:setCharVar("THE_FIGHTING_FOURTH", 1)
    end
end
