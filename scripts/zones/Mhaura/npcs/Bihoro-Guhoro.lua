-----------------------------------
-- Area: Mhaura
--  NPC: Bihoro-Guhoro
-- Involved in Quest: Riding on the Clouds
-- !pos -28 -8 41 249
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_3") == 7) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_3", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SOMBER_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SOMBER_STONE)
        end
    end

end

function onTrigger(player, npc)
    player:startEvent(750)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
