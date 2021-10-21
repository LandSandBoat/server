-----------------------------------
-- Area: Windurst Waters
--  NPC: Jack of Hearts
-- Adventurer's Assistant
-- Working 100%
-----------------------------------
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536, 1) == true) then
        player:startEvent(10012, xi.settings.GIL_RATE*50)
        player:addGil(xi.settings.GIL_RATE*50)
        player:tradeComplete()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(10011, 0, 1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
