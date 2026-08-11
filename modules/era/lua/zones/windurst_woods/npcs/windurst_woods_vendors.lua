-----------------------------------
-- Windurst Woods Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('windurst_woods_vendors_adjust', xi.pre(xi.expansion.ABYSSEA))

-- Mono Nchaa: Rework stock for in era items and conquest standing requirements
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Windurst_Woods.npcs.Mono_Nchaa.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.LIGHT_CROSSBOW,               180, 2 },
        { xi.item.HAWKEYE,                       61, 2 },
        { xi.item.WOODEN_ARROW,                   4, 2 },
        { xi.item.BONE_ARROW,                     5, 3 },
        { xi.item.CROSSBOW_BOLT,                  6, 3 },
        { xi.item.SCROLL_OF_HUNTERS_PRELUDE,   2880, 3 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.MONONCHAA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end)

-- Wije Tiren: Remove Federation Waystone from stock
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Windurst_Woods.npcs.Wije_Tiren.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,        2595 },
        { xi.item.ANTIDOTE,                   316 },
        { xi.item.FLASK_OF_ECHO_DROPS,        800 },
        { xi.item.POTION,                     910 },
        { xi.item.ETHER,                     4832 },
        { xi.item.SCROLL_OF_HERB_PASTORAL,    108 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.WIJETIREN_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end)

-- Quesse: Rework broth prices for in era values
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Windurst_Woods.npcs.Quesse.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS,       67, 3 },
        { xi.item.CHOCOBO_FEATHER,               8, 3 },
        { xi.item.DART,                         10, 2 },
        { xi.item.BLACK_CHOCOBO_FEATHER,      1250, 1 },
        { xi.item.PET_FOOD_ALPHA_BISCUIT,       12, 3 },
        { xi.item.PET_FOOD_BETA_BISCUIT,        89, 3 },
        { xi.item.JUG_OF_CARROT_BROTH,          90, 3 },
        { xi.item.JUG_OF_BUG_BROTH,            756, 3 },
        { xi.item.JUG_OF_HERBAL_BROTH,         138, 3 },
        { xi.item.JUG_OF_CARRION_BROTH,        756, 3 },
        { xi.item.SCROLL_OF_CHOCOBO_MAZURKA, 55200, 3 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.QUESSE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end)
