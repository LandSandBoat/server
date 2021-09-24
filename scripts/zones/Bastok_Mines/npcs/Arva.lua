-----------------------------------
-- Area: Bastok Mines
--  NPC: Arva
-- Adventurer's Assistant
-- Working 100%
-----------------------------------
require("scripts/settings/main")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536, 1) == true) then
        player:startEvent(4)
        player:addGil(xi.settings.GIL_RATE * 50)
        player:tradeComplete()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(3)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 4) then
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 50)
    end
end

return entity
