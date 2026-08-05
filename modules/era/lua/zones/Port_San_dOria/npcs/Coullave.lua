-----------------------------------
-- Coullave Shop Adjustments
-- Remove items not sold in this era
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'coullave_shop_adjust'

if xi.module.isContentEnabled('WOTG') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.zones.Port_San_dOria.npcs.Coullave.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.LEATHER_RING,        1250, 3 },
        { xi.item.HACHIMAKI,            825, 1 },
        { xi.item.KENPOGI,             1245, 1 },
        { xi.item.TEKKO,                685, 1 },
        { xi.item.SITABAKI,             995, 1 },
        { xi.item.KYAHAN,               635, 1 },
        { xi.item.BAMBOO_STICK,         144, 2 },
        { xi.item.FLASK_OF_EYE_DROPS,  2595, 3 },
        { xi.item.ANTIDOTE,             316, 3 },
        { xi.item.FLASK_OF_ECHO_DROPS,  800, 2 },
        { xi.item.POTION,               910, 1 },
        { xi.item.ETHER,               4832, 1 },
        { xi.item.GRENADE,             1204, 1 },
    }

    player:showText(npc, zones[xi.zone.PORT_SAN_DORIA].text.COULLAVE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end)

return m
