-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Justi
-- Conquest depending furniture seller
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SPOOL_OF_BUNDLING_TWINE,    100, 3, },
        { xi.item.WATER_CASK,                 375, 3, },
        { xi.item.CUPBOARD,                 11508, 3, },
        { xi.item.OAK_TABLE,                93600, 3, },
        { xi.item.DRESSER,                 164160, 1, },
        { xi.item.ARMOR_BOX,                 6070, 3, },
        { xi.item.COFFER,                   25560, 2, },
        { xi.item.CABINET,                  67200, 1, },
        { xi.item.CHIFFONIER,               55128, 1, },
    }

    player:showText(npc, ID.text.JUSTI_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
