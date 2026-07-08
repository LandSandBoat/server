-----------------------------------
-- Chayaya Shop Adjustments
-- Removes OOE Corsair rolls added to shop inventory in the WotG era
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'chayaya_shop_adjust'

if xi.module.isContentEnabled('WOTG') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.zones.Al_Zahbi.npcs.Chayaya.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.DART,               10, },
        { xi.item.HAWKEYE,            60, },
        { xi.item.GRENADE,          1204, },
        { xi.item.IRON_ARROW,          8, },
        { xi.item.WARRIOR_DIE,     68000, },
        { xi.item.MONK_DIE,        22400, },
        { xi.item.WHITE_MAGE_DIE,   5000, },
        { xi.item.BLACK_MAGE_DIE, 108000, },
        { xi.item.RED_MAGE_DIE,    62000, },
        { xi.item.THIEF_DIE,       50400, },
        { xi.item.PALADIN_DIE,     90750, },
        { xi.item.DARK_KNIGHT_DIE,  2205, },
        { xi.item.BEASTMASTER_DIE, 26600, },
        { xi.item.BARD_DIE,        12780, },
        { xi.item.RANGER_DIE,       1300, },
    }

    player:showText(npc, zones[xi.zone.AL_ZAHBI].text.CHAYAYA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end)

return m
