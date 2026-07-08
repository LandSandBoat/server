-----------------------------------
-- Jajaroon Shop Adjustments
-- Removes Trump Card Case added in Abyssea
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'jajaroon_shop_adjust'

if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.zones.Al_Zahbi.npcs.Chayaya.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.FIRE_CARD,           48 },
        { xi.item.ICE_CARD,            48 },
        { xi.item.WIND_CARD,           48 },
        { xi.item.EARTH_CARD,          48 },
        { xi.item.THUNDER_CARD,        48 },
        { xi.item.WATER_CARD,          48 },
        { xi.item.LIGHT_CARD,          48 },
        { xi.item.DARK_CARD,           48 },
        { xi.item.SAMURAI_DIE,      35200 },
        { xi.item.NINJA_DIE,          600 },
        { xi.item.DRAGOON_DIE,       9216 },
        { xi.item.SUMMONER_DIE,     40000 },
        { xi.item.BLUE_MAGE_DIE,     3525 },
        { xi.item.CORSAIR_DIE,        316 },
        { xi.item.PUPPETMASTER_DIE, 82500 },
    }

    player:showText(npc, zones[xi.zone.NASHMAU].text.JAJAROON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end)

return m
