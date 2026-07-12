-----------------------------------
-- Bastok Markets Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'bastok_markets_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ROV') then
    -- Harmodios: Rework stock for in era items and conquest standing requirements
    m:addOverride('xi.zones.Bastok_Markets.npcs.Harmodios.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.GEMSHORN,                    5416, 3 },
            { xi.item.CORNETTE,                     256, 2 },
            { xi.item.FLUTE,                         50, 3 },
            { xi.item.PICCOLO,                     1144, 1 },
            { xi.item.MAPLE_HARP,                    50, 2 },
            { xi.item.SCROLL_OF_VITAL_ETUDE,      80640, 2 },
            { xi.item.SCROLL_OF_SWIFT_ETUDE,      77280, 2 },
            { xi.item.SCROLL_OF_SAGE_ETUDE,       73920, 2 },
            { xi.item.SCROLL_OF_LOGICAL_ETUDE,    66150, 2 },
            { xi.item.SCROLL_OF_BEWITCHING_ETUDE, 63000, 3 },
            { xi.item.SCROLL_OF_HERCULEAN_ETUDE,  92820, 2 },
            { xi.item.SCROLL_OF_UNCANNY_ETUDE,    89250, 2 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.HARMODIOS_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)
end

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Ciqala: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Bastok_Markets.npcs.Ciqala.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRONZE_KNUCKLES,   256, 3 },
            { xi.item.BRASS_KNUCKLES,    945, 2 },
            { xi.item.METAL_KNUCKLES,   5447, 1 },
            { xi.item.BATTLEAXE,       12757, 1 },
            { xi.item.GREATAXE,         4732, 1 },
            { xi.item.BRONZE_HAMMER,     357, 3 },
            { xi.item.BRASS_HAMMER,     2430, 2 },
            { xi.item.WARHAMMER,        6820, 1 },
            { xi.item.BRONZE_AXE,        328, 3 },
            { xi.item.BRASS_AXE,        1622, 2 },
            { xi.item.BUTTERFLY_AXE,     698, 2 },
            { xi.item.MAPLE_WAND,         54, 3 },
            { xi.item.ASH_STAFF,          67, 3 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.CIQALA_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Hortense: Remove OOE Bard spells from stock
    m:addOverride('xi.zones.Bastok_Markets.npcs.Hortense.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_FOE_REQUIEM,        75, 3 },
            { xi.item.SCROLL_OF_FOE_REQUIEM_II,    514, 3 },
            { xi.item.SCROLL_OF_FOE_REQUIEM_III,  4620, 3 },
            { xi.item.SCROLL_OF_FOE_REQUIEM_IV,   8064, 3 },
            { xi.item.SCROLL_OF_ARMYS_PAEON,        44, 3 },
            { xi.item.SCROLL_OF_ARMYS_PAEON_II,    374, 3 },
            { xi.item.SCROLL_OF_ARMYS_PAEON_III,  3780, 3 },
            { xi.item.SCROLL_OF_ARMYS_PAEON_IV,   6930, 3 },
            { xi.item.SCROLL_OF_VALOR_MINUET,       25, 3 },
            { xi.item.SCROLL_OF_VALOR_MINUET_II,  1285, 3 },
            { xi.item.SCROLL_OF_VALOR_MINUET_III, 6468, 3 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.HORTENSE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Peritrage: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Bastok_Markets.npcs.Peritrage.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.LIGHT_CROSSBOW,   187, 3 },
            { xi.item.CROSSBOW,        2449, 2 },
            { xi.item.ZAMBURAK,       16005, 1 },
            { xi.item.TATHLUM,          332, 1 },
            { xi.item.CROSSBOW_BOLT,      6, 3 },
            { xi.item.MYTHRIL_BOLT,      24, 2 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.PERITRAGE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Zhikkom: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Bastok_Markets.npcs.Zhikkom.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRONZE_SWORD,    281, 3 },
            { xi.item.IRON_SWORD,     8316, 2 },
            { xi.item.MYTHRIL_SWORD, 35776, 1 },
            { xi.item.BROADSWORD,    24344, 1 },
            { xi.item.DEGEN,         10735, 3 },
            { xi.item.TUCK,          13391, 1 },
            { xi.item.SAPARA,          814, 3 },
            { xi.item.SCIMITAR,       4751, 2 },
            { xi.item.FALCHION,      70720, 1 },
            { xi.item.BRONZE_KNIFE,    170, 3 },
            { xi.item.KNIFE,          2522, 2 },
            { xi.item.KUKRI,          6458, 1 },
            { xi.item.CAT_BAGHNAKHS,   120, 3 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.ZHIKKOM_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Charging Chocobo: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Bastok_Markets.npcs.Charging_Chocobo.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRONZE_SUBLIGAR,    218, 3 },
            { xi.item.SCALE_CUISSES,     1879, 3 },
            { xi.item.BRASS_CUISSES,    16228, 2 },
            { xi.item.CUISSES,          39690, 2 },
            { xi.item.MYTHRIL_CUISSES,  66399, 1 },
            { xi.item.BRONZE_LEGGINGS,    134, 3 },
            { xi.item.SCALE_GREAVES,     1139, 3 },
            { xi.item.BRASS_GREAVES,     9609, 2 },
            { xi.item.PLATE_LEGGINGS,   24948, 2 },
            { xi.item.MYTHRIL_LEGGINGS, 41527, 1 },
            { xi.item.GORGET,           19278, 2 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.CHARGINGCHOCOBO_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Mjoll: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Bastok_Markets.npcs.Mjoll.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.WOODEN_ARROW,               4, 2 },
            { xi.item.IRON_ARROW,                 8, 3 },
            { xi.item.SILVER_ARROW,              18, 1 },
            { xi.item.SCROLL_OF_DARK_THRENODY,  227, 3 },
            { xi.item.SCROLL_OF_ICE_THRENODY,  1142, 3 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.MJOLL_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)
end

-- Sororo: Remove Repose scroll from stock, add Aquaveil (only sold pre-WOTG)
if not xi.module.isContentEnabled('WOTG') then
    m:addOverride('xi.zones.Bastok_Markets.npcs.Sororo.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_CURE,        71, 3 },
            { xi.item.SCROLL_OF_CURE_II,    682, 2 },
            { xi.item.SCROLL_OF_CURAGA,    1590, 3 },
            { xi.item.SCROLL_OF_POISONA,    210, 3 },
            { xi.item.SCROLL_OF_PARALYNA,   378, 3 },
            { xi.item.SCROLL_OF_BLINDNA,   1155, 3 },
            { xi.item.SCROLL_OF_DIA,         96, 3 },
            { xi.item.SCROLL_OF_BANISH,     163, 2 },
            { xi.item.SCROLL_OF_DIAGA,     1359, 1 },
            { xi.item.SCROLL_OF_BANISHGA,  1359, 2 },
            { xi.item.SCROLL_OF_PROTECT,    256, 3 },
            { xi.item.SCROLL_OF_SHELL,     1848, 3 },
            { xi.item.SCROLL_OF_BLINK,     2446, 2 },
            { xi.item.SCROLL_OF_STONESKIN, 8118, 1 },
            { xi.item.SCROLL_OF_SLOW,       967, 1 },
            { xi.item.SCROLL_OF_AQUAVEIL,   424, 3 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.SORORO_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)
end

return m
