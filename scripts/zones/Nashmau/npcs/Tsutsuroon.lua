-----------------------------------
-- Area: Nashmau
--  NPC: Tsutsuroon
-- Type: Tenshodo Merchant
-- !pos -15.193 0.000 31.356 53
-----------------------------------
require("scripts/globals/shop")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Nashmau/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        if player:sendGuild(60431, 1, 23, 7) then
            player:showText(npc, ID.text.TSUTSUROON_SHOP_DIALOG)
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
