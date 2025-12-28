-----------------------------------
-- Area: Port Bastok
--  NPC: Numa
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HACHIMAKI,                 866, 2 },
        { xi.item.COTTON_HACHIMAKI,         5079, 1 },
        { xi.item.KENPOGI,                  1307, 2 },
        { xi.item.COTTON_DOGI,              7654, 1 },
        { xi.item.TEKKO,                     719, 2 },
        { xi.item.COTTON_TEKKO,             4212, 1 },
        { xi.item.SITABAKI,                 1044, 2 },
        { xi.item.COTTON_SITABAKI,          6133, 1 },
        { xi.item.KYAHAN,                    666, 2 },
        { xi.item.COTTON_KYAHAN,            3924, 1 },
        { xi.item.SILVER_OBI,               3825, 1 },
        { xi.item.BAMBOO_STICK,              151, 2 },
        { xi.item.TOOLBAG_INOSHISHINOFUDA, 15750, 3 },
        { xi.item.TOOLBAG_SHIKANOFUDA,     21000, 3 },
        { xi.item.TOOLBAG_CHONOFUDA,       21000, 3 },
        { xi.item.PICKAXE,                   210, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_BASTOK].text.NUMA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
