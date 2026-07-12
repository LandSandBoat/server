-----------------------------------
-- Nogga Shop Adjustments
-- Remove items not sold in this era
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'nogga_shop_adjust'

if xi.module.isContentEnabled('WOTG') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.zones.Metalworks.npcs.Nogga.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.BOMB_ARM, 787, 2 },
        { xi.item.GRENADE, 1264, 3 },
    }

    player:showText(npc, zones[xi.zone.METALWORKS].text.NOGGA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end)

return m
