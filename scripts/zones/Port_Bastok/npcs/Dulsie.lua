-----------------------------------
-- Area: Port Bastok
--  NPC: Dulsie
-- Adventurer's Assistant
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(536, 1) and trade:getItemCount() == 1 then
        player:startEvent(8)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(7)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 8 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 50)
    end
end

return entity
