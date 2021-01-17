-----------------------------------
-- Area: Bastok Markets
--  NPC: Yafafa
-- Kolshushu Regional Goods
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(tpz.region.KOLSHUSHU) ~= tpz.nation.BASTOK then
        player:showText(npc, ID.text.YAFAFA_CLOSED_DIALOG)
    else
        local stock =
        {
            4503,  184,    --Buburimu Grape
            1120, 1620,    --Casablanca
            4359,  220,    --Dhalmel Meat
            614,    72,    --Mhaura Garlic
            4445,   40,     --Yagudo Cherry
        }

        player:showText(npc, ID.text.YAFAFA_OPEN_DIALOG)
        tpz.shop.general(player, stock, BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
