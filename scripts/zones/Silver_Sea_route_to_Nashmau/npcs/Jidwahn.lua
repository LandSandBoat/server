-----------------------------------
-- Area: Silver Sea route to Nashmau
--  NPC: Jidwahn
-- Guild Merchant NPC: Fishing Guild
-- !pos 4.986 -2.101 -12.026 58
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Silver_Sea_route_to_Nashmau/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(524, 1, 23, 5) then
        player:showText(npc, ID.text.JIDWAHN_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
