-----------------------------------
-- Northern San d'Oria Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'northern_san_doria_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Arlenne: Rework stock for in era items and conquest standing requirements
    m:addOverride('xi.zones.Northern_San_dOria.npcs.Arlenne.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.MAPLE_WAND,       52, 3 },
            { xi.item.WILLOW_WAND,     370, 2 },
            { xi.item.YEW_WAND,       1566, 1 },
            { xi.item.ASH_STAFF,        63, 3 },
            { xi.item.HOLLY_STAFF,     635, 2 },
            { xi.item.ELM_STAFF,      3606, 1 },
            { xi.item.HOLLY_POLE,     5076, 2 },
            { xi.item.ELM_POLE,      18240, 1 },
            { xi.item.BRONZE_ZAGHNAL,  344, 3 },
            { xi.item.BRASS_ZAGHNAL,  2825, 2 },
            { xi.item.ZAGHNAL,       12540, 1 },
            { xi.item.BRONZE_SPEAR,    880, 3 },
            { xi.item.BRASS_SPEAR,    5200, 2 },
            { xi.item.SPEAR,         17640, 1 },
            { xi.item.LANCE,         18420, 1 },
        }

        player:showText(npc, zones[xi.zone.NORTHERN_SAN_DORIA].text.ARLENNE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)

    -- Tavourine: Rework stock for in era items and conquest standing requirements
    m:addOverride('xi.zones.Northern_San_dOria.npcs.Tavourine.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRONZE_KNIFE,       164, 2 },
            { xi.item.KNIFE,             2425, 1 },
            { xi.item.BRONZE_ROD,         100, 3 },
            { xi.item.BRASS_ROD,          690, 2 },
            { xi.item.ROD,               2652, 1 },
            { xi.item.BRONZE_MACE,        188, 3 },
            { xi.item.MACE,              4848, 2 },
            { xi.item.BRONZE_AXE,         316, 2 },
            { xi.item.CLAYMORE,          2720, 2 },
            { xi.item.MYTHRIL_CLAYMORE, 42000, 1 },
        }

        player:showText(npc, zones[xi.zone.NORTHERN_SAN_DORIA].text.TAVOURINE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)

    -- Pirvidiauce: Remove Kingdom Waystone from stock
    m:addOverride('xi.zones.Northern_San_dOria.npcs.Pirvidiauce.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.CERAMIC_FLOWERPOT,    1000, 3 },
            { xi.item.PILE_OF_RED_GRAVEL,   2205, 3 },
            { xi.item.ASH_CLOGS,             124, 3 },
            { xi.item.HOLLY_CLOGS,          1625, 2 },
            { xi.item.CHESTNUT_SABOTS,      9180, 1 },
            { xi.item.WOODEN_ARROW,            4, 3 },
            { xi.item.CROSSBOW_BOLT,           6, 2 },
            { xi.item.FLASK_OF_EYE_DROPS,   2595, 3 },
            { xi.item.ANTIDOTE,              316, 3 },
            { xi.item.FLASK_OF_ECHO_DROPS,   800, 2 },
            { xi.item.POTION,                910, 1 },
            { xi.item.ETHER,                4832, 1 },
        }

        player:showText(npc, zones[xi.zone.NORTHERN_SAN_DORIA].text.PIRVIDIAUCE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)
end

return m
