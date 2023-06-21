-----------------------------------
-- Area: Metalworks
--  NPC: Amulya
-- Type: Guild Merchant (Blacksmithing Guild)
-- !pos -106.093 0.999 -24.564 237
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(5332, 8, 23, 2) then
        player:showText(npc, ID.text.AMULYA_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
