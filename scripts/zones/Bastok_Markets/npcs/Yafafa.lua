-----------------------------------
-- Area: Bastok Markets
--  NPC: Yafafa
-- Kolshushu Regional Goods
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.KOLSHUSHU) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.YAFAFA_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.BULB_OF_MHAURA_GARLIC,      83,
            xi.item.YAGUDO_CHERRY,              45,
            xi.item.SLICE_OF_DHALMEL_MEAT,     249,
            xi.item.BUNCH_OF_BUBURIMU_GRAPES,  208,
            xi.item.CASABLANCA,               1872,
        }

        player:showText(npc, ID.text.YAFAFA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
