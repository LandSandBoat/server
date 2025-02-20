-----------------------------------
-- Area: Port San d'Oria
--  NPC: Coullave
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.LEATHER_RING,        1300, 3,
        xi.item.SILVER_EARRING,      1300, 2,
        xi.item.HACHIMAKI,            858, 2,
        xi.item.KENPOGI,             1294, 2,
        xi.item.TEKKO,                712, 2,
        xi.item.SITABAKI,            1034, 2,
        xi.item.KYAHAN,               660, 2,
        xi.item.BAMBOO_STICK,         149, 2,
        xi.item.FLASK_OF_EYE_DROPS,  2698, 3,
        xi.item.ANTIDOTE,             328, 3,
        xi.item.FLASK_OF_ECHO_DROPS,  832, 2,
        xi.item.POTION,               946, 1,
        xi.item.ETHER,               5025, 1,
        xi.item.GRENADE,             1252, 1,
    }

    player:showText(npc, ID.text.COULLAVE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
