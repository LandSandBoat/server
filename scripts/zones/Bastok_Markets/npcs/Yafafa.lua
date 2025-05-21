-----------------------------------
-- Area: Bastok Markets
--  NPC: Yafafa
-- Kolshushu Regional Goods
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.KOLSHUSHU) ~= xi.nation.BASTOK then
        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.YAFAFA_CLOSED_DIALOG)
    else
        local stock =
        {
            { xi.item.BULB_OF_MHAURA_GARLIC,      84 },
            { xi.item.YAGUDO_CHERRY,              46 },
            { xi.item.SLICE_OF_DHALMEL_MEAT,     252 },
            { xi.item.BUNCH_OF_BUBURIMU_GRAPES,  210 },
            { xi.item.CASABLANCA,               1890 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.YAFAFA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
