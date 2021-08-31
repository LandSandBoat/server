-----------------------------------
-- Area: Giddeus
--  NPC: Giddeus Spring
-- Involved in Quest "Water Way to Go"
-- !pos -258 -2 -249 145
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/Giddeus/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(504, 1) and trade:getItemCount() == 1) then
            player:startEvent(55)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(54)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 55) then
        player:tradeComplete()
        player:addItem(4351)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4351)
    end
end

return entity
