-----------------------------------
-- Windurst Woods Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'windurst_woods_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Mono Nchaa: Rework stock for in era items and conquest standing requirements
    m:addOverride('xi.zones.Windurst_Woods.npcs.Mono_Nchaa.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.LIGHT_CROSSBOW,               187, 2 },
            { xi.item.HAWKEYE,                       62, 2 },
            { xi.item.WOODEN_ARROW,                   4, 2 },
            { xi.item.BONE_ARROW,                     5, 3 },
            { xi.item.CROSSBOW_BOLT,                  6, 3 },
            { xi.item.SCROLL_OF_HUNTERS_PRELUDE,   2995, 3 },
        }

        player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.MONONCHAA_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.WINDURST)
    end)

    -- Wije Tiren: Remove Federation Waystone from stock
    m:addOverride('xi.zones.Windurst_Woods.npcs.Wije_Tiren.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.FLASK_OF_EYE_DROPS,        2698 },
            { xi.item.ANTIDOTE,                   328 },
            { xi.item.FLASK_OF_ECHO_DROPS,        832 },
            { xi.item.POTION,                     946 },
            { xi.item.ETHER,                     5025 },
            { xi.item.SCROLL_OF_HERB_PASTORAL,    112 },
            { xi.item.FLASK_OF_DISTILLED_WATER,    12 },
        }

        player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.WIJETIREN_SHOP_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end)
end

return m
