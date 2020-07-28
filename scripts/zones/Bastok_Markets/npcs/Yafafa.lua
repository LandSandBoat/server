-----------------------------------
-- Area: Bastok Markets
--  NPC: Yafafa
-- Kolshushu Regional Goods
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
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

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
