-----------------------------------
-- Area: Windurst Waters
--  NPC: Kopopo
-- Guild Merchant NPC: Cooking Guild
-- !pos -103.935 -2.875 74.304 238
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(530, 5, 20, 7) then
        player:showText(npc, ID.text.KOPOPO_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
