-----------------------------------
-- Area: Norg
--  NPC: Jirokichi
-- Type: Tenshodo Merchant
-- !pos -1.463 0.000 18.846 252
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60423, 9, 23, 7)) then
            player:showText(npc, ID.text.JIROKICHI_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
