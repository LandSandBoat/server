-----------------------------------
-- Bastok Mines Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'bastok_mines_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Boytz: Remove Republic Waystone from stock
    m:addOverride('xi.zones.Bastok_Mines.npcs.Boytz.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRASS_FLOWERPOT,     1000, 3 },
            { xi.item.PICKAXE,              200, 3 },
            { xi.item.FLASK_OF_EYE_DROPS,  2595, 3 },
            { xi.item.ANTIDOTE,             316, 3 },
            { xi.item.FLASK_OF_ECHO_DROPS,  800, 2 },
            { xi.item.POTION,               910, 2 },
            { xi.item.ETHER,               4786, 1 },
            { xi.item.WOODEN_ARROW,           4, 2 },
            { xi.item.IRON_ARROW,             8, 3 },
            { xi.item.CROSSBOW_BOLT,          6, 3 },
        }

        -- Thief's tools.
        if GetNationRank(player:getNation()) >= 2 then -- Player nation rank 2 or 3.
            table.insert(stock, { xi.item.SET_OF_THIEFS_TOOLS, 3960, 3 })
        end

        -- Living Key.
        local sandyNationRank  = GetNationRank(xi.nation.SANDORIA)
        local bastokNationRank = GetNationRank(xi.nation.BASTOK)
        local windyNationRank  = GetNationRank(xi.nation.WINDURST)
        if
            (bastokNationRank == sandyNationRank and bastokNationRank == windyNationRank) or                        -- All 3 nations tied.
            (bastokNationRank ~= sandyNationRank and bastokNationRank ~= windyNationRank and bastokNationRank == 3) -- Nation not tied and nation last.
        then
            table.insert(stock, { xi.item.LIVING_KEY, 5870, 3 })
        end

        player:showText(npc, zones[xi.zone.BASTOK_MINES].text.BOYTZ_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Zemedars: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Bastok_Mines.npcs.Zemedars.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRONZE_SUBLIGAR,     208, 3 },
            { xi.item.BRASS_SUBLIGAR,     2000, 2 },
            { xi.item.IRON_SUBLIGAR,     25102, 1 },
            { xi.item.LEATHER_TROUSERS,    536, 2 },
            { xi.item.LIZARD_TROUSERS,    5387, 1 },
            { xi.item.CHAIN_HOSE,        12600, 3 },
            { xi.item.BRONZE_LEGGINGS,     128, 3 },
            { xi.item.BRASS_LEGGINGS,     1240, 2 },
            { xi.item.LEGGINGS,          15594, 1 },
            { xi.item.LEATHER_HIGHBOOTS,   336, 2 },
            { xi.item.LIZARD_LEDELSENS,   3405, 1 },
            { xi.item.GREAVES,            7740, 3 },
            { xi.item.MAPLE_SHIELD,        605, 3 },
            { xi.item.LAUAN_SHIELD,        120, 3 },
            { xi.item.TARGE,             12040, 2 },
            { xi.item.BUCKLER,           33960, 1 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MINES].text.ZEMEDARS_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Neigepance: Rework broth prices for in era values
    m:addOverride('xi.zones.Bastok_Mines.npcs.Neigepance.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS,       68, 3 },
            { xi.item.CHOCOBO_FEATHER,               8, 3 },
            { xi.item.DART,                         10, 1 },
            { xi.item.BLACK_CHOCOBO_FEATHER,      1239, 1 },
            { xi.item.PET_FOOD_ALPHA_BISCUIT,       11, 3 },
            { xi.item.PET_FOOD_BETA_BISCUIT,        90, 3 },
            { xi.item.JUG_OF_CARROT_BROTH,          90, 3 },
            { xi.item.JUG_OF_BUG_BROTH,            756, 3 },
            { xi.item.JUG_OF_HERBAL_BROTH,         138, 3 },
            { xi.item.JUG_OF_CARRION_BROTH,        756, 3 },
            { xi.item.SCROLL_OF_CHOCOBO_MAZURKA, 55200, 3 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MINES].text.NEIGEPANCE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)
end

return m
