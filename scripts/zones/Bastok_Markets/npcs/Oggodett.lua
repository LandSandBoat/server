-----------------------------------
-- Area: Bastok Markets
--  NPC: Oggodett
-- Aragoneu Regional Goods
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ARAGONEU) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.OGGODETT_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.BAG_OF_HORO_FLOUR,           41,
            xi.item.EAR_OF_MILLIONCORN,          49,
            xi.item.EAR_OF_ROASTED_CORN,        128,
            xi.item.YAGUDO_FEATHER,              41,
            xi.item.HANDFUL_OF_SUNFLOWER_SEEDS, 104,
        }

        player:showText(npc, ID.text.OGGODETT_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
