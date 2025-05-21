-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Phamelise
-- Zulkheim Regional Merchant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ZULKHEIM) == xi.nation.SANDORIA then
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

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.PHAMELISE_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    else
        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.PHAMELISE_CLOSED_DIALOG)
    end
end

return entity
