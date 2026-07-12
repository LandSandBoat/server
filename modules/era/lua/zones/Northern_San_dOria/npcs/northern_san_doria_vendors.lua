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
            { xi.item.MAPLE_WAND,       54, 3 },
            { xi.item.WILLOW_WAND,     384, 2 },
            { xi.item.YEW_WAND,       1628, 1 },
            { xi.item.ASH_STAFF,        66, 3 },
            { xi.item.HOLLY_STAFF,     660, 2 },
            { xi.item.ELM_STAFF,      3750, 1 },
            { xi.item.HOLLY_POLE,     5279, 2 },
            { xi.item.ELM_POLE,      18969, 1 },
            { xi.item.BRONZE_ZAGHNAL,  357, 3 },
            { xi.item.BRASS_ZAGHNAL,  2938, 2 },
            { xi.item.ZAGHNAL,       13041, 1 },
            { xi.item.BRONZE_SPEAR,    932, 3 },
            { xi.item.BRASS_SPEAR,    5408, 2 },
            { xi.item.SPEAR,         18345, 1 },
            { xi.item.LANCE,         19156, 1 },
        }

        player:showText(npc, zones[xi.zone.NORTHERN_SAN_DORIA].text.ARLENNE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)

    -- Tavourine: Rework stock for in era items and conquest standing requirements
    m:addOverride('xi.zones.Northern_San_dOria.npcs.Tavourine.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRONZE_KNIFE,       170, 2 },
            { xi.item.KNIFE,             2522, 1 },
            { xi.item.BRONZE_ROD,         104, 3 },
            { xi.item.BRASS_ROD,          717, 2 },
            { xi.item.ROD,               2758, 1 },
            { xi.item.BRONZE_MACE,        195, 3 },
            { xi.item.MACE,              5041, 2 },
            { xi.item.BRONZE_AXE,         328, 2 },
            { xi.item.CLAYMORE,          2828, 2 },
            { xi.item.MYTHRIL_CLAYMORE, 43680, 1 },
        }

        player:showText(npc, zones[xi.zone.NORTHERN_SAN_DORIA].text.TAVOURINE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)

    -- Pirvidiauce: Remove Kingdom Waystone from stock
    m:addOverride('xi.zones.Northern_San_dOria.npcs.Pirvidiauce.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.CERAMIC_FLOWERPOT,    1040, 3 },
            { xi.item.PILE_OF_RED_GRAVEL,   2293, 3 },
            { xi.item.ASH_CLOGS,             128, 3 },
            { xi.item.HOLLY_CLOGS,          1690, 2 },
            { xi.item.CHESTNUT_SABOTS,      9547, 1 },
            { xi.item.WOODEN_ARROW,            4, 3 },
            { xi.item.CROSSBOW_BOLT,           6, 2 },
            { xi.item.FLASK_OF_EYE_DROPS,   2698, 3 },
            { xi.item.ANTIDOTE,              328, 3 },
            { xi.item.FLASK_OF_ECHO_DROPS,   832, 2 },
            { xi.item.POTION,                946, 1 },
            { xi.item.ETHER,                5025, 1 },
        }

        player:showText(npc, zones[xi.zone.NORTHERN_SAN_DORIA].text.PIRVIDIAUCE_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.SANDORIA)
    end)
end

return m
