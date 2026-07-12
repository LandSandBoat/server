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
            { xi.item.BRONZE_DAGGER,   162, 3 },
            { xi.item.BRASS_DAGGER,    967, 3 },
            { xi.item.DAGGER,         2111, 2 },
            { xi.item.BASELARD,       4979, 1 },
            { xi.item.BRASS_XIPHOS,   4071, 3 },
            { xi.item.GLADIUS,       19568, 1 },
            { xi.item.BRONZE_SWORD,    278, 3 },
            { xi.item.IRON_SWORD,     8236, 2 },
            { xi.item.BROADSWORD,    24344, 1 },
            { xi.item.SPATHA,         1934, 3 },
            { xi.item.LONGSWORD,      9584, 2 },
            { xi.item.HUNTING_SWORD, 41333, 1 },
            { xi.item.FLEURET,       15491, 1 },
            { xi.item.CESTI,           149, 3 },
        }

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.ASH_THADI_ENE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)

    -- Carautia: Rework stock for in era items and conquest standing requirements
    m:addOverride('xi.zones.Southern_San_dOria.npcs.Carautia.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.MAPLE_SHIELD,        629, 3 },
            { xi.item.MAHOGANY_SHIELD,    5179, 2 },
            { xi.item.KITE_SHIELD,       11880, 1 },
            { xi.item.BRONZE_SUBLIGAR,     216, 3 },
            { xi.item.BRASS_SUBLIGAR,     2080, 3 },
            { xi.item.LEATHER_TROUSERS,    557, 3 },
            { xi.item.STUDDED_TROUSERS,  19127, 2 },
            { xi.item.CHAIN_HOSE,        13104, 1 },
            { xi.item.BRONZE_LEGGINGS,     133, 3 },
            { xi.item.BRASS_LEGGINGS,     1289, 3 },
            { xi.item.LEATHER_HIGHBOOTS,   349, 3 },
            { xi.item.STUDDED_BOOTS,     11618, 2 },
            { xi.item.GREAVES,            8049, 1 },
        }

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.CARAUTIA_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)

    -- Ferdoulemiont: Remove Scroll of Knight's Minne V from stock
    m:addOverride('xi.zones.Southern_San_dOria.npcs.Ferdoulemiont.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS,         70, 3 },
            { xi.item.CHOCOBO_FEATHER,                 8, 3 },
            { xi.item.SCROLL_OF_KNIGHTS_MINNE,        18, 3 },
            { xi.item.SCROLL_OF_KNIGHTS_MINNE_II,    998, 3 },
            { xi.item.SCROLL_OF_KNIGHTS_MINNE_III,  5948, 3 },
            { xi.item.DART,                           10, 2 },
            { xi.item.BLACK_CHOCOBO_FEATHER,        1300, 1 },
            { xi.item.PET_FOOD_ALPHA_BISCUIT,         12, 3 },
            { xi.item.PET_FOOD_BETA_BISCUIT,          93, 3 },
            { xi.item.JUG_OF_CARROT_BROTH,            62, 3 },
            { xi.item.JUG_OF_BUG_BROTH,              101, 3 },
            { xi.item.JUG_OF_HERBAL_BROTH,           112, 3 },
            { xi.item.JUG_OF_CARRION_BROTH,          313, 3 },
            { xi.item.SCROLL_OF_CHOCOBO_MAZURKA,   57408, 3 },
            { xi.item.LA_THEINE_MILLET,             2293, 3 },
        }

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.FERDOULEMIONT_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)
end

if not xi.module.isContentEnabled('WOTG') then
    -- Benaige: Remove Paprika and Zucchini from stock
    m:addOverride('xi.zones.Southern_San_dOria.npcs.Benaige.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.POT_OF_CRYING_MUSTARD,      29, 3 },
            { xi.item.PINCH_OF_DRIED_MARJORAM,    49, 2 },
            { xi.item.BAG_OF_RYE_FLOUR,           41, 3 },
            { xi.item.BAG_OF_SAN_DORIAN_FLOUR,    62, 2 },
            { xi.item.BAG_OF_SEMOLINA,          2080, 2 },
            { xi.item.POT_OF_MAPLE_SUGAR,         41, 2 },
            { xi.item.STICK_OF_CINNAMON,         270, 1 },
            { xi.item.EAR_OF_MILLIONCORN,         49, 1 },
            { xi.item.CHUNK_OF_ROCK_SALT,         16, 3 },
            { xi.item.FLASK_OF_DISTILLED_WATER,   12, 3 },
            { xi.item.SPRIG_OF_CIBOL,            228, 3 },
        }

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.RAIMBROYS_SHOP_DIALOG + 1)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)
end

return m
