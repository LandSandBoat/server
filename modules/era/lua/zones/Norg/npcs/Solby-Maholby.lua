-----------------------------------
-- Solby-Maholby Shop Adjustments
-- Removes many OOE NIN spell scrolls from stock
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'solby_maholby_shop_adjust'

if xi.module.isContentEnabled('SOA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.zones.Norg.npcs.Solby-Maholby.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.LUGWORM,                      9 },
        { xi.item.EARTH_SPIRIT_PACT,          450 },
    }

    player:showText(npc, zones[xi.zone.NORG].text.SOLBYMAHOLBY_SHOP_DIALOG, 0, 0, 0, 0, true, false)
    xi.shop.general(player, stock)
end)

return m
