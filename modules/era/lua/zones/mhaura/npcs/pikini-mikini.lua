-----------------------------------
-- Pikini-Mkini Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('mhaura_vendors_adjust', xi.pre(xi.expansion.SOA))

-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Mhaura.npcs.Pikini-Mikini.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,       2595 },
        { xi.item.ANTIDOTE,                  316 },
        { xi.item.FLASK_OF_ECHO_DROPS,       800 },
        { xi.item.POTION,                    910 },
        { xi.item.FLASK_OF_DISTILLED_WATER,   12 },
        { xi.item.LUGWORM,                    12 },
        { xi.item.HATCHET,                   500 },
        { xi.item.STRIP_OF_MEAT_JERKY,       120 },
        { xi.item.DISH_OF_SALSA,             148 },
        { xi.item.SCROLL_OF_REGEN,          4320 },
        { xi.item.SCROLL_OF_REGEN_II,       7830 },
        { xi.item.SCROLL_OF_SLEEPGA,       11200 },
    }

    player:showText(npc, zones[xi.zone.MHAURA].text.PIKINIMIKINI_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end)
