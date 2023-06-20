-----------------------------------
-- Area: Al Zahbi
--  NPC: Ndego
--  Guild Merchant NPC: Smithing Guild
-- !pos -37.192 0.000 -33.949 48
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(60427, 8, 23, 2) then
        player:showText(npc, ID.text.NDEGO_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
