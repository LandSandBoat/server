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
        xi.item.SPOOL_OF_BUNDLING_TWINE,     92, 3,
        xi.item.WATER_CASK,                 518, 3,
        xi.item.CUPBOARD,                 15881, 3,
        xi.item.OAK_TABLE,               129168, 3,
        xi.item.DRESSER,                 170726, 1,
        xi.item.ARMOR_BOX,                 8376, 3,
        xi.item.COFFER,                   35272, 2,
        xi.item.CABINET,                  69888, 1,
        xi.item.CHIFFONIER,               57333, 1,
    }

    player:showText(npc, ID.text.JUSTI_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
