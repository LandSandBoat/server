-----------------------------------
-- Area: Norg
--  NPC: Chiyo
-- Type: Tenshodo Merchant
-- !pos 5.801 0.020 -18.739 252
-----------------------------------
require("scripts/globals/shop")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(60422, 9, 23, 7) then
        player:showText(npc, ID.text.CHIYO_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
