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
        { xi.item.LEATHER_RING,        1250, 3, },
        { xi.item.SILVER_EARRING,      1250, 2, },
        { xi.item.HACHIMAKI,            825, 2, },
        { xi.item.KENPOGI,             1245, 2, },
        { xi.item.TEKKO,                685, 2, },
        { xi.item.SITABAKI,            995, 2, },
        { xi.item.KYAHAN,               635, 2, },
        { xi.item.BAMBOO_STICK,         144, 2, },
        { xi.item.FLASK_OF_EYE_DROPS,  2595, 3, },
        { xi.item.ANTIDOTE,             316, 3, },
        { xi.item.FLASK_OF_ECHO_DROPS,  800, 2, },
        { xi.item.POTION,               910, 1, },
        { xi.item.ETHER,               4832, 1, },
        { xi.item.GRENADE,             1204, 1, },
    }

    player:showText(npc, ID.text.COULLAVE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
