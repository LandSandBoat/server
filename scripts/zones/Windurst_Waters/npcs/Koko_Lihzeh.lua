-----------------------------------
-- Area: Windurst Waters
--  NPC: Koko Lihzeh
-- Involved in Quest: Making the Grade, Riding on the Clouds
-- !pos 135 -6 162 238
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_4") == 1) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_4", 0)
            player:tradeComplete()
            player:addKeyItem(xi.ki.SPIRITED_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SPIRITED_STONE)
        end
    end

end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED) then
        player:startEvent(451) -- During Making the GRADE
    else
        player:startEvent(428) -- Standard conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
