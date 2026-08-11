-----------------------------------
-- Numa Shop Adjustments
-- Remove ninjutsu toolbags from stock
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('numa_shop_adjust', xi.pre(xi.expansion.ABYSSEA))

-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Port_Bastok.npcs.Numa.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.HACHIMAKI,          825, 2 },
        { xi.item.COTTON_HACHIMAKI,  4838, 1 },
        { xi.item.KENPOGI,           1245, 2 },
        { xi.item.COTTON_DOGI,       7290, 1 },
        { xi.item.TEKKO,              685, 2 },
        { xi.item.COTTON_TEKKO,      4012, 1 },
        { xi.item.SITABAKI,           995, 2 },
        { xi.item.COTTON_SITABAKI,   5841, 1 },
        { xi.item.KYAHAN,             635, 2 },
        { xi.item.COTTON_KYAHAN,     3738, 1 },
        { xi.item.SILVER_OBI,        3643, 1 },
        { xi.item.BAMBOO_STICK,       144, 2 },
        { xi.item.PICKAXE,            200, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_BASTOK].text.NUMA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end)
