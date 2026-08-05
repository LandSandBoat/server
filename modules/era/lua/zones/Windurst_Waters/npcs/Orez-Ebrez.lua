-----------------------------------
-- Orez-Ebrez Shop Adjustments
-- Remove items not sold in this era
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'orez_ebrez_shop_adjust'

if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.zones.Windurst_Waters.npcs.Orez-Ebrez.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.HEADGEAR,          1936, 3 },
        { xi.item.CIRCLET,            160, 2 },
        { xi.item.POETS_CIRCLET,     2070, 2 },
        { xi.item.HACHIMAKI,          825, 3 },
        { xi.item.COTTON_HEADBAND,   2000, 3 },
        { xi.item.BRONZE_CAP,         168, 3 },
        { xi.item.COTTON_HEADGEAR,   8918, 2 },
        { xi.item.LEATHER_BANDANA,    440, 2 },
        { xi.item.FLAX_HEADBAND,    16000, 2 },
        { xi.item.COTTON_HACHIMAKI,  4884, 2 },
        { xi.item.BRASS_CAP,         1635, 3 },
        { xi.item.WOOL_HAT,         12138, 2 },
        { xi.item.RED_CAP,          20000, 1 },
        { xi.item.SOIL_HACHIMAKI,   13392, 1 },
        { xi.item.BEETLE_MASK,       7638, 1 },
        { xi.item.BONE_MASK,         3912, 2 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WATERS].text.OREZEBREZ_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end)

return m
