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
        { xi.item.LEATHER_RING,        1300, 3 },
        { xi.item.HACHIMAKI,            858, 1 },
        { xi.item.KENPOGI,             1294, 1 },
        { xi.item.TEKKO,                712, 1 },
        { xi.item.SITABAKI,            1034, 1 },
        { xi.item.KYAHAN,               660, 1 },
        { xi.item.BAMBOO_STICK,         149, 2 },
        { xi.item.FLASK_OF_EYE_DROPS,  2698, 3 },
        { xi.item.ANTIDOTE,             328, 3 },
        { xi.item.FLASK_OF_ECHO_DROPS,  832, 2 },
        { xi.item.POTION,               946, 1 },
        { xi.item.ETHER,               5025, 1 },
        { xi.item.GRENADE,             1252, 1 },
    }

    player:showText(npc, zones[xi.zone.PORT_SAN_DORIA].text.COULLAVE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end)

return m
