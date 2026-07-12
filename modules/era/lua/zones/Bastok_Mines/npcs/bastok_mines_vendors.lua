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
            { xi.item.BRASS_FLOWERPOT,     1050, 3 },
            { xi.item.PICKAXE,              210, 3 },
            { xi.item.FLASK_OF_EYE_DROPS,  2724, 3 },
            { xi.item.ANTIDOTE,             331, 3 },
            { xi.item.FLASK_OF_ECHO_DROPS,  840, 2 },
            { xi.item.POTION,               955, 2 },
            { xi.item.ETHER,               5025, 1 },
            { xi.item.WOODEN_ARROW,           4, 2 },
            { xi.item.IRON_ARROW,             8, 3 },
            { xi.item.CROSSBOW_BOLT,          6, 3 },
        }

        -- Thief's tools.
        if GetNationRank(player:getNation()) >= 2 then -- Player nation rank 2 or 3.
            table.insert(stock, { xi.item.SET_OF_THIEFS_TOOLS, 4158, 3 })
        end

        -- Living Key.
        local sandyNationRank  = GetNationRank(xi.nation.SANDORIA)
        local bastokNationRank = GetNationRank(xi.nation.BASTOK)
        local windyNationRank  = GetNationRank(xi.nation.WINDURST)
        if
            (bastokNationRank == sandyNationRank and bastokNationRank == windyNationRank) or                        -- All 3 nations tied.
            (bastokNationRank ~= sandyNationRank and bastokNationRank ~= windyNationRank and bastokNationRank == 3) -- Nation not tied and nation last.
        then
            table.insert(stock, { xi.item.LIVING_KEY, 5520, 3 })
        end

        player:showText(npc, zones[xi.zone.BASTOK_MINES].text.BOYTZ_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)

    -- Zemedars: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Bastok_Mines.npcs.Zemedars.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRONZE_SUBLIGAR,     218, 3 },
            { xi.item.BRASS_SUBLIGAR,     2100, 2 },
            { xi.item.IRON_SUBLIGAR,     26357, 1 },
            { xi.item.LEATHER_TROUSERS,    562, 2 },
            { xi.item.LIZARD_TROUSERS,    5656, 1 },
            { xi.item.CHAIN_HOSE,        13230, 3 },
            { xi.item.BRONZE_LEGGINGS,     134, 3 },
            { xi.item.BRASS_LEGGINGS,     1302, 2 },
            { xi.item.LEGGINGS,          16373, 1 },
            { xi.item.LEATHER_HIGHBOOTS,   352, 2 },
            { xi.item.LIZARD_LEDELSENS,   3575, 1 },
            { xi.item.GREAVES,            8127, 3 },
            { xi.item.MAPLE_SHIELD,        635, 3 },
            { xi.item.LAUAN_SHIELD,        126, 3 },
            { xi.item.TARGE,             12642, 2 },
            { xi.item.BUCKLER,           35658, 1 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MINES].text.ZEMEDARS_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.BASTOK)
    end)
end

return m
