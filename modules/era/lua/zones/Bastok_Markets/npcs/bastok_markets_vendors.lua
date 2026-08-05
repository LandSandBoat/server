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
            { xi.item.GEMSHORN,                    5159, 3 },
            { xi.item.CORNETTE,                     244, 2 },
            { xi.item.FLUTE,                         49, 3 },
            { xi.item.PICCOLO,                     1090, 1 },
            { xi.item.MAPLE_HARP,                    49, 2 },
            { xi.item.SCROLL_OF_VITAL_ETUDE,      76800, 2 },
            { xi.item.SCROLL_OF_SWIFT_ETUDE,      73600, 2 },
            { xi.item.SCROLL_OF_SAGE_ETUDE,       70400, 2 },
            { xi.item.SCROLL_OF_LOGICAL_ETUDE,    63000, 2 },
            { xi.item.SCROLL_OF_BEWITCHING_ETUDE, 60000, 3 },
            { xi.item.SCROLL_OF_HERCULEAN_ETUDE,  88400, 2 },
            { xi.item.SCROLL_OF_UNCANNY_ETUDE,    85000, 2 },
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
            { xi.item.BRONZE_KNUCKLES,   244, 3 },
            { xi.item.BRASS_KNUCKLES,    900, 2 },
            { xi.item.METAL_KNUCKLES,   5188, 1 },
            { xi.item.BATTLEAXE,       12150, 1 },
            { xi.item.GREATAXE,         4732, 1 },
            { xi.item.BRONZE_HAMMER,     340, 3 },
            { xi.item.BRASS_HAMMER,     2315, 2 },
            { xi.item.WARHAMMER,        6496, 1 },
            { xi.item.BRONZE_AXE,        328, 3 },
            { xi.item.BRASS_AXE,        1622, 2 },
            { xi.item.BUTTERFLY_AXE,     698, 2 },
            { xi.item.MAPLE_WAND,         51, 3 },
            { xi.item.ASH_STAFF,          64, 3 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.CIQALA_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Hortense: Remove OOE Bard spells from stock
    m:addOverride('xi.zones.Bastok_Markets.npcs.Hortense.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_FOE_REQUIEM,        71, 3 },
            { xi.item.SCROLL_OF_FOE_REQUIEM_II,    490, 3 },
            { xi.item.SCROLL_OF_FOE_REQUIEM_III,  4400, 3 },
            { xi.item.SCROLL_OF_FOE_REQUIEM_IV,   7680, 3 },
            { xi.item.SCROLL_OF_ARMYS_PAEON,        42, 3 },
            { xi.item.SCROLL_OF_ARMYS_PAEON_II,    357, 3 },
            { xi.item.SCROLL_OF_ARMYS_PAEON_III,  3600, 3 },
            { xi.item.SCROLL_OF_ARMYS_PAEON_IV,   6600, 3 },
            { xi.item.SCROLL_OF_VALOR_MINUET,       25, 3 },
            { xi.item.SCROLL_OF_VALOR_MINUET_II,  1224, 3 },
            { xi.item.SCROLL_OF_VALOR_MINUET_III, 6160, 3 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.HORTENSE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Peritrage: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Bastok_Markets.npcs.Peritrage.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.LIGHT_CROSSBOW,   179, 3 },
            { xi.item.CROSSBOW,        2449, 2 },
            { xi.item.ZAMBURAK,       15243, 1 },
            { xi.item.TATHLUM,          320, 1 },
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
            { xi.item.BRONZE_SWORD,    268, 3 },
            { xi.item.IRON_SWORD,     7920, 2 },
            { xi.item.MYTHRIL_SWORD, 34073, 1 },
            { xi.item.BROADSWORD,    23185, 1 },
            { xi.item.DEGEN,         10224, 3 },
            { xi.item.TUCK,          12754, 1 },
            { xi.item.SAPARA,          776, 3 },
            { xi.item.SCIMITAR,       4525, 2 },
            { xi.item.FALCHION,      67353, 1 },
            { xi.item.BRONZE_KNIFE,    164, 3 },
            { xi.item.KNIFE,          2425, 2 },
            { xi.item.KUKRI,          6151, 1 },
            { xi.item.CAT_BAGHNAKHS,   116, 3 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.ZHIKKOM_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Charging Chocobo: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Bastok_Markets.npcs.Charging_Chocobo.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRONZE_SUBLIGAR,    208, 3 },
            { xi.item.SCALE_CUISSES,     1790, 3 },
            { xi.item.BRASS_CUISSES,    15456, 2 },
            { xi.item.CUISSES,          37800, 2 },
            { xi.item.MYTHRIL_CUISSES,  63238, 1 },
            { xi.item.BRONZE_LEGGINGS,    128, 3 },
            { xi.item.SCALE_GREAVES,     1085, 3 },
            { xi.item.BRASS_GREAVES,     9152, 2 },
            { xi.item.PLATE_LEGGINGS,   23760, 2 },
            { xi.item.MYTHRIL_LEGGINGS, 39550, 1 },
            { xi.item.GORGET,           18360, 2 },
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
            { xi.item.SILVER_ARROW,              17, 1 },
            { xi.item.SCROLL_OF_DARK_THRENODY,  217, 3 },
            { xi.item.SCROLL_OF_ICE_THRENODY,  1088, 3 },
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
            { xi.item.SCROLL_OF_CURE,        68, 3 },
            { xi.item.SCROLL_OF_CURE_II,    650, 2 },
            { xi.item.SCROLL_OF_CURAGA,    1515, 3 },
            { xi.item.SCROLL_OF_POISONA,    200, 3 },
            { xi.item.SCROLL_OF_PARALYNA,   360, 3 },
            { xi.item.SCROLL_OF_BLINDNA,   1100, 3 },
            { xi.item.SCROLL_OF_DIA,         91, 3 },
            { xi.item.SCROLL_OF_BANISH,     156, 2 },
            { xi.item.SCROLL_OF_DIAGA,     1295, 1 },
            { xi.item.SCROLL_OF_BANISHGA,  1295, 2 },
            { xi.item.SCROLL_OF_PROTECT,    244, 3 },
            { xi.item.SCROLL_OF_SHELL,     1760, 3 },
            { xi.item.SCROLL_OF_BLINK,     2330, 2 },
            { xi.item.SCROLL_OF_STONESKIN, 7732, 1 },
            { xi.item.SCROLL_OF_SLOW,       921, 1 },
            { xi.item.SCROLL_OF_AQUAVEIL,   424, 3 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.SORORO_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)
end

return m
