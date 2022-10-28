-----------------------------------
-- Area: Ship bound for Selbina
--  NPC: Rajmonda
-- Type: Guild Merchant: Fishing Guild
-- !pos 1.841 -2.101 -9.000 220
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Selbina/IDs")
require("scripts/globals/settings")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(520, 1, 23, 5) then
        player:showText(npc, ID.text.RAJMONDA_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
