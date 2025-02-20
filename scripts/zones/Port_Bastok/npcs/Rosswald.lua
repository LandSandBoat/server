-----------------------------------
-- Area: Port Bastok
--  NPC: Rosswald
-- Zulkheim Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ZULKHEIM) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.ROSSWALD_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.SLICE_OF_GIANT_SHEEP_MEAT,   49,
            xi.item.PINCH_OF_DRIED_MARJORAM,     49,
            xi.item.BAG_OF_SAN_DORIAN_FLOUR,     62,
            xi.item.BAG_OF_RYE_FLOUR,            41,
            xi.item.BAG_OF_SEMOLINA,           2080,
            xi.item.LA_THEINE_CABBAGE,           24,
            xi.item.JUG_OF_SELBINA_MILK,         62,
        }

        player:showText(npc, ID.text.ROSSWALD_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
