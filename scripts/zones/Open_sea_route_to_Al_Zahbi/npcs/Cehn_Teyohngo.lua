-----------------------------------
-- Area: Open sea route to Al Zahbi
--  NPC: Cehn Teyohngo
-- Guild Merchant NPC: Fishing Guild
-- !pos 4.986 -2.101 -12.026 46
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Open_sea_route_to_Al_Zahbi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(522, 1, 23, 5) then
        player:showText(npc, ID.text.CEHN_TEYOHNGO_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
