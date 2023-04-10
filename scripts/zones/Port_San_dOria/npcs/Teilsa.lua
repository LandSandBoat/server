-----------------------------------
-- Area: Port San d'Oria
--  NPC: Teilsa
-- Adventurer's Assistant
-- Only recieving Adv.Coupon and simple talk event are scrited
-- This NPC participates in Quests and Missions
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:getItemCount() == 1 and trade:hasItemQty(536, 1) then
        player:startEvent(612)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(573)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 612 then
        player:tradeComplete()

        npcUtil.giveCurrency(player, 'gil', 50)
    end
end

return entity
