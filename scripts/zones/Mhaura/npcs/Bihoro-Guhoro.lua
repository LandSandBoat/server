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
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_3") == 7) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_3", 0)
            player:tradeComplete()
            player:addKeyItem(xi.ki.SOMBER_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SOMBER_STONE)
        end
    end

end

entity.onTrigger = function(player, npc)
    player:startEvent(750)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
