-----------------------------------
-- Area: Port San d'Oria
--  NPC: Brifalien
-- Involved in Quests: Riding on the Clouds
-- !pos -20 -4 -74 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_1") == 7 and npcUtil.tradeHas(trade, 1127) then
        player:setCharVar("ridingOnTheClouds_1", 0)
        npcUtil.giveKeyItem(player, tpz.ki.SCOWLING_STONE)
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_BRIFALIEN)
    else
        player:startEvent(589)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
