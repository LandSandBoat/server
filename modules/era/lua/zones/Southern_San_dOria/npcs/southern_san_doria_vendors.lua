-----------------------------------
-- Southern San d'Oria Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'southern_san_doria_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Ashene: Rework stock for in era items and conquest standing requirements
    m:addOverride('xi.zones.Southern_San_dOria.npcs.Ashene.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRONZE_DAGGER,   156, 3 },
            { xi.item.BRASS_DAGGER,    930, 3 },
            { xi.item.DAGGER,         2030, 2 },
            { xi.item.BASELARD,       4788, 1 },
            { xi.item.BRASS_XIPHOS,   3915, 3 },
            { xi.item.GLADIUS,       18816, 1 },
            { xi.item.BRONZE_SWORD,    268, 3 },
            { xi.item.IRON_SWORD,     7920, 2 },
            { xi.item.BROADSWORD,    27778, 1 },
            { xi.item.SPATHA,         1860, 3 },
            { xi.item.LONGSWORD,      9216, 2 },
            { xi.item.HUNTING_SWORD, 39744, 1 },
            { xi.item.FLEURET,       14896, 1 },
            { xi.item.CESTI,           144, 3 },
        }

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.ASH_THADI_ENE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)

    -- Carautia: Rework stock for in era items and conquest standing requirements
    m:addOverride('xi.zones.Southern_San_dOria.npcs.Carautia.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.MAPLE_SHIELD,        605, 3 },
            { xi.item.MAHOGANY_SHIELD,    4980, 2 },
            { xi.item.KITE_SHIELD,       11424, 1 },
            { xi.item.BRONZE_SUBLIGAR,     208, 3 },
            { xi.item.BRASS_SUBLIGAR,     2000, 3 },
            { xi.item.LEATHER_TROUSERS,    536, 3 },
            { xi.item.STUDDED_TROUSERS,  18392, 2 },
            { xi.item.CHAIN_HOSE,        12600, 1 },
            { xi.item.BRONZE_LEGGINGS,     128, 3 },
            { xi.item.BRASS_LEGGINGS,     1240, 3 },
            { xi.item.LEATHER_HIGHBOOTS,   336, 3 },
            { xi.item.STUDDED_BOOTS,     11172, 2 },
            { xi.item.GREAVES,            7740, 1 },
        }

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.CARAUTIA_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)

    -- Ferdoulemiont: Remove Scroll of Knight's Minne V from stock
    m:addOverride('xi.zones.Southern_San_dOria.npcs.Ferdoulemiont.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS,         67, 3 },
            { xi.item.CHOCOBO_FEATHER,                 8, 3 },
            { xi.item.SCROLL_OF_KNIGHTS_MINNE,        17, 3 },
            { xi.item.SCROLL_OF_KNIGHTS_MINNE_II,    960, 3 },
            { xi.item.SCROLL_OF_KNIGHTS_MINNE_III,  5720, 3 },
            { xi.item.DART,                           10, 2 },
            { xi.item.BLACK_CHOCOBO_FEATHER,        1250, 1 },
            { xi.item.PET_FOOD_ALPHA_BISCUIT,         12, 3 },
            { xi.item.PET_FOOD_BETA_BISCUIT,          89, 3 },
            { xi.item.JUG_OF_CARROT_BROTH,            90, 3 },
            { xi.item.JUG_OF_BUG_BROTH,              756, 3 },
            { xi.item.JUG_OF_HERBAL_BROTH,           138, 3 },
            { xi.item.JUG_OF_CARRION_BROTH,          756, 3 },
            { xi.item.SCROLL_OF_CHOCOBO_MAZURKA,   55200, 3 },
            { xi.item.LA_THEINE_MILLET,             2205, 3 },
        }

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.FERDOULEMIONT_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)

    -- Ostalie: Rework Living Key price for in era value
    m:addOverride('xi.zones.Southern_San_dOria.npcs.Ostalie.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.LEATHER_BELT,          425, 3 },
            { xi.item.LIZARD_BELT,          2700, 3 },
            { xi.item.SILVER_BELT,         11172, 1 },
            { xi.item.CIRCLET,               160, 3 },
            { xi.item.ROBE,                  240, 3 },
            { xi.item.CUFFS,                 132, 3 },
            { xi.item.SLOPS,                 192, 3 },
            { xi.item.FLASK_OF_EYE_DROPS,   2595, 3 },
            { xi.item.ANTIDOTE,              316, 3 },
            { xi.item.FLASK_OF_ECHO_DROPS,   800, 2 },
            { xi.item.POTION,                910, 1 },
            { xi.item.ETHER,                4832, 1 },
            { xi.item.PICKAXE,               200, 3 },
            { xi.item.HATCHET,               500, 3 },
        }

        -- Thief's tools.
        if GetNationRank(player:getNation()) >= 2 then -- Player nation rank 2 or 3.
            table.insert(stock, { xi.item.SET_OF_THIEFS_TOOLS, 3999, 3 })
        end

        -- Living Key.
        local sandyNationRank  = GetNationRank(xi.nation.SANDORIA)
        local bastokNationRank = GetNationRank(xi.nation.BASTOK)
        local windyNationRank  = GetNationRank(xi.nation.WINDURST)
        if
            (sandyNationRank == bastokNationRank and sandyNationRank == windyNationRank) or                       -- All 3 nations tied.
            (sandyNationRank ~= bastokNationRank and sandyNationRank ~= windyNationRank and sandyNationRank == 3) -- Nation not tied and nation last.
        then
            table.insert(stock, { xi.item.LIVING_KEY, 6467, 3 })
        end

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.OSTALIE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)
end

if not xi.module.isContentEnabled('WOTG') then
    -- Benaige: Remove Paprika and Zucchini from stock
    m:addOverride('xi.zones.Southern_San_dOria.npcs.Benaige.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.POT_OF_CRYING_MUSTARD,      28, 3 },
            { xi.item.PINCH_OF_DRIED_MARJORAM,    48, 2 },
            { xi.item.BAG_OF_RYE_FLOUR,           40, 3 },
            { xi.item.BAG_OF_SAN_DORIAN_FLOUR,    61, 2 },
            { xi.item.BAG_OF_SEMOLINA,          2000, 2 },
            { xi.item.POT_OF_MAPLE_SUGAR,         40, 2 },
            { xi.item.STICK_OF_CINNAMON,         260, 1 },
            { xi.item.EAR_OF_MILLIONCORN,         48, 1 },
            { xi.item.CHUNK_OF_ROCK_SALT,         15, 3 },
            { xi.item.FLASK_OF_DISTILLED_WATER,   12, 3 },
            { xi.item.SPRIG_OF_CIBOL,            220, 3 },
        }

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.RAIMBROYS_SHOP_DIALOG + 1)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)
end

return m
