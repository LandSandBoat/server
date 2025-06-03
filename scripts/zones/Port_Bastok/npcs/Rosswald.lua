-----------------------------------
-- Area: Port Bastok
--  NPC: Rosswald
-- Zulkheim Regional Merchant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ZULKHEIM) == xi.nation.BASTOK then
        local stock =
        {
            { xi.item.SLICE_OF_GIANT_SHEEP_MEAT,   50 },
            { xi.item.PINCH_OF_DRIED_MARJORAM,     50 },
            { xi.item.BAG_OF_SAN_DORIAN_FLOUR,     63 },
            { xi.item.BAG_OF_RYE_FLOUR,            42 },
            { xi.item.BAG_OF_SEMOLINA,           2100 },
            { xi.item.LA_THEINE_CABBAGE,           25 },
            { xi.item.JUG_OF_SELBINA_MILK,         63 },
        }

        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.ROSSWALD_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    else
        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.ROSSWALD_CLOSED_DIALOG)
    end
end

return entity
