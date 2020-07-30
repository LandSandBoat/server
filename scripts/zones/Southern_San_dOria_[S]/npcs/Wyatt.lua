-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Wyatt
-- !pos 124 0 84 80
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 4 and trade:hasItemQty(2506, 4)) then
        player:startEvent(4)
    end
end

function onTrigger(player, npc)
    local seeingSpots = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.SEEING_SPOTS)
    if (seeingSpots == QUEST_AVAILABLE) then
        player:startEvent(2)
    elseif (seeingSpots == QUEST_ACCEPTED) then
        player:startEvent(3)
    else
        player:showText(npc, ID.text.WYATT_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 2) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.SEEING_SPOTS)
    elseif (csid == 4) then
        player:tradeComplete()
        if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.SEEING_SPOTS) == QUEST_ACCEPTED) then
            player:addTitle(tpz.title.LADY_KILLER)
            player:addGil(GIL_RATE*3000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*3000)
            player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.SEEING_SPOTS)
        else
            player:addTitle(tpz.title.LADY_KILLER)
            player:addGil(GIL_RATE*3000)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*3000)
        end
    end
end
