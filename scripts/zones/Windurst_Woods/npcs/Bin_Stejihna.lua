-----------------------------------
-- Area: Windurst_Woods
--  NPC: Bin Stejihna
-- Only sells when Windurst controlls Zulkheim Region
-- Confirmed shop stock, August 2013
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ZULKHEIM) == xi.nation.WINDURST then
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

        player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.BIN_STEJIHNA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    else
        player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.BIN_STEJIHNA_CLOSED_DIALOG)
    end
end

return entity
