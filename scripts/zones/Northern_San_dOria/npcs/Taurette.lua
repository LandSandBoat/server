-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Taurette
-- Involved in Quests: Riding on the Clouds
-- !pos -159 0 91 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_1") == 3) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_1", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SCOWLING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SCOWLING_STONE)
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(664)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
