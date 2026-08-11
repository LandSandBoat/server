-----------------------------------
-- Nogga Shop Adjustments
-- Remove items not sold in this era
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('nogga_shop_adjust', xi.pre(xi.expansion.WOTG))

-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Metalworks.npcs.Nogga.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.BOMB_ARM, 750, 2 },
        { xi.item.GRENADE, 1204, 3 },
    }

    player:showText(npc, zones[xi.zone.METALWORKS].text.NOGGA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end)
