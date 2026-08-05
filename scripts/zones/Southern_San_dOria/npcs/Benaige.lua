-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Benaige
-- !pos -142 -6 47 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.POT_OF_CRYING_MUSTARD,      28, 3, },
        { xi.item.PINCH_OF_DRIED_MARJORAM,    48, 2, },
        { xi.item.BAG_OF_RYE_FLOUR,           40, 3, },
        { xi.item.BAG_OF_SAN_DORIAN_FLOUR,    61, 2, },
        { xi.item.BAG_OF_SEMOLINA,          2000, 2, },
        { xi.item.POT_OF_MAPLE_SUGAR,         40, 2, },
        { xi.item.STICK_OF_CINNAMON,         260, 1, },
        { xi.item.EAR_OF_MILLIONCORN,         48, 1, },
        { xi.item.CHUNK_OF_ROCK_SALT,         15, 3, },
        { xi.item.FLASK_OF_DISTILLED_WATER,   12, 3, },
        { xi.item.SPRIG_OF_CIBOL,            220, 3, },
        { xi.item.ZUCCHINI,                  492, 2, },
        { xi.item.CLUSTER_OF_PAPRIKA,        568, 2, },
    }

    player:showText(npc, ID.text.RAIMBROYS_SHOP_DIALOG + 1)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
