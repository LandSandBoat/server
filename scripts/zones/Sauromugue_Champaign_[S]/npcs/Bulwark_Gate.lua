-----------------------------------
-- Area: Sauromugue Champaign [S]
--  NPC: Bulwark Gate
-- !pos -445 0 342
-- Quest NPC
-----------------------------------
require("scripts/globals/campaign")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.KNOT_QUITE_THERE) == QUEST_ACCEPTED and player:getCharVar("KnotQuiteThere") == 1) then
        if (trade:hasItemQty(2562, 1) == true and trade:getGil() == 0 and trade:getItemCount() == 1) then
            player:startEvent(106)
        end
    end
end

function onTrigger(player, npc)
    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.KNOT_QUITE_THERE) == QUEST_ACCEPTED) then
        if (player:getCharVar("KnotQuiteThere") == 0) then
            player:startEvent(105)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 105) then
        player:setCharVar("KnotQuiteThere", 1)
    elseif (csid == 106) then
        player:tradeComplete()
        player:setCharVar("KnotQuiteThere", 2)
    end
end
