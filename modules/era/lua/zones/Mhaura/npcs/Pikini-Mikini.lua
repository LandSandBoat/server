-----------------------------------
-- Pikini-Mkini Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'mhaura_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('SOA') then
    m:addOverride('xi.zones.Mhaura.npcs.Pikini-Mikini.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.FLASK_OF_EYE_DROPS,       2698 },
            { xi.item.ANTIDOTE,                  328 },
            { xi.item.FLASK_OF_ECHO_DROPS,       832 },
            { xi.item.POTION,                    946 },
            { xi.item.FLASK_OF_DISTILLED_WATER,   12 },
            { xi.item.LUGWORM,                    12 },
            { xi.item.HATCHET,                   520 },
            { xi.item.STRIP_OF_MEAT_JERKY,       124 },
            { xi.item.DISH_OF_SALSA,             153 },
            { xi.item.SCROLL_OF_REGEN,          4492 },
            { xi.item.SCROLL_OF_REGEN_II,       8143 },
            { xi.item.SCROLL_OF_SLEEPGA,       11648 },
        }

        player:showText(npc, zones[xi.zone.MHAURA].text.PIKINIMIKINI_SHOP_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end)
end

return m
