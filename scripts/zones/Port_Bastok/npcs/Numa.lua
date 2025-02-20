-----------------------------------
-- Area: Port Bastok
--  NPC: Numa
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.HACHIMAKI,                 858, 2,
        xi.item.COTTON_HACHIMAKI,         5079, 1,
        xi.item.KENPOGI,                  1294, 2,
        xi.item.COTTON_DOGI,              7654, 1,
        xi.item.TEKKO,                     712, 2,
        xi.item.COTTON_TEKKO,             4212, 1,
        xi.item.SITABAKI,                 1034, 2,
        xi.item.COTTON_SITABAKI,          6133, 1,
        xi.item.KYAHAN,                    660, 2,
        xi.item.COTTON_KYAHAN,            3924, 1,
        xi.item.SILVER_OBI,               3825, 1,
        xi.item.BAMBOO_STICK,              149, 2,
        xi.item.TOOLBAG_INOSHISHINOFUDA, 15600, 3,
        xi.item.TOOLBAG_SHIKANOFUDA,     20800, 3,
        xi.item.TOOLBAG_CHONOFUDA,       20800, 3,
        xi.item.PICKAXE,                   208, 3,
    }

    player:showText(npc, ID.text.NUMA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
