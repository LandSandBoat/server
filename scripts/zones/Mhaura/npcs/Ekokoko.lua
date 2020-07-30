-----------------------------------
-- Area: Mhaura
--  NPC: Ekokoko
-- Gouvernor of Mhaura
-- Involved in Quest: Riding on the Clouds
-- !pos -78 -24 28 249
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_3") == 6) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_3", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SOMBER_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SOMBER_STONE)
        end
    end

end

function onTrigger(player, npc)

    if (math.random() > 0.5) then
        player:startEvent(51)
    else
        player:startEvent(52)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
