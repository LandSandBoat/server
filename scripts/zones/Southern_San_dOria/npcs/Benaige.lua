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
        xi.item.POT_OF_CRYING_MUSTARD,      29, 3,
        xi.item.PINCH_OF_DRIED_MARJORAM,    49, 2,
        xi.item.BAG_OF_RYE_FLOUR,           41, 3,
        xi.item.BAG_OF_SAN_DORIAN_FLOUR,    62, 2,
        xi.item.BAG_OF_SEMOLINA,          2080, 2,
        xi.item.POT_OF_MAPLE_SUGAR,         41, 2,
        xi.item.STICK_OF_CINNAMON,         270, 1,
        xi.item.EAR_OF_MILLIONCORN,         49, 1,
        xi.item.CHUNK_OF_ROCK_SALT,         16, 3,
        xi.item.FLASK_OF_DISTILLED_WATER,   12, 3,
        xi.item.SPRIG_OF_CIBOL,            228, 3,
        xi.item.ZUCCHINI,                  511, 2,
        xi.item.CLUSTER_OF_PAPRIKA,        590, 2,
    }

    player:showText(npc, ID.text.RAIMBROYS_SHOP_DIALOG + 1)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
