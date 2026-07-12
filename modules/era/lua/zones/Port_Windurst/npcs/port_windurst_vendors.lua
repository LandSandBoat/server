-----------------------------------
-- Port Windurst Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'port_windurst_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Hohbiba-Mubiba: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Port_Windurst.npcs.Hohbiba-Mubiba.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.MAPLE_WAND,           54, 3 },
            { xi.item.WILLOW_WAND,         384, 2 },
            { xi.item.YEW_WAND,           1628, 1 },
            { xi.item.BRONZE_ROD,          104, 1 },
            { xi.item.ASH_CLUB,             74, 3 },
            { xi.item.CHESTNUT_CLUB,      1809, 3 },
            { xi.item.BONE_CUDGEL,        5591, 2 },
            { xi.item.ASH_STAFF,            66, 3 },
            { xi.item.HOLLY_STAFF,         660, 2 },
            { xi.item.ELM_STAFF,          3750, 1 },
            { xi.item.ASH_POLE,            436, 3 },
            { xi.item.HOLLY_POLE,         5279, 2 },
            { xi.item.ELM_POLE,          18969, 1 },
            { xi.item.BRONZE_DAGGER,       162, 3 },
        }

        player:showText(npc, zones[xi.zone.PORT_WINDURST].text.HOHBIBAMUBIBA_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.WINDURST)
    end)

    -- Taniko-Maniko: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Port_Windurst.npcs.Taniko-Maniko.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.CAT_BAGHNAKHS,       120, 2 },
            { xi.item.CESTI,               149, 2 },
            { xi.item.BONE_AXE,           4851, 3 },
            { xi.item.BONE_PICK,          6776, 2 },
            { xi.item.BRONZE_ZAGHNAL,      357, 3 },
            { xi.item.BRASS_ZAGHNAL,      2938, 1 },
            { xi.item.HARPOON,             112, 3 },
            { xi.item.WRAPPED_BOW,        8236, 1 },
            { xi.item.ICE_ARROW,           145, 1 },
            { xi.item.LIGHTNING_ARROW,     145, 1 },
            { xi.item.SELF_BOW,            557, 2 },
            { xi.item.WOODEN_ARROW,          4, 2 },
            { xi.item.HAWKEYE,              62, 2 },
            { xi.item.BOOMERANG,          1820, 2 },
            { xi.item.SHORTBOW,             45, 3 },
            { xi.item.BONE_ARROW,            5, 3 },
        }

        player:showText(npc, zones[xi.zone.PORT_WINDURST].text.TANIKOMANIKO_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.WINDURST)
    end)

    -- Guruna-Maguruna: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Port_Windurst.npcs.Guruna-Maguruna.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.HEMP_GORGET,        1123, 3 },
            { xi.item.BEETLE_GORGET,      4854, 1 },
            { xi.item.DOUBLET,            2854, 3 },
            { xi.item.ROBE,                249, 3 },
            { xi.item.LEATHER_VEST,        698, 3 },
            { xi.item.TUNIC,              1456, 2 },
            { xi.item.COTTON_DOUBLET,    14277, 2 },
            { xi.item.LINEN_ROBE,         3208, 1 },
            { xi.item.GLOVES,             1575, 3 },
            { xi.item.CUFFS,               137, 3 },
            { xi.item.LEATHER_GLOVES,      374, 2 },
            { xi.item.MITTS,               681, 2 },
            { xi.item.COTTON_GLOVES,      7737, 2 },
            { xi.item.LINEN_CUFFS,        1814, 1 },
        }

        player:showText(npc, zones[xi.zone.PORT_WINDURST].text.GURUNAMAGURUNA_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.WINDURST)
    end)

    -- Kumama: Rework inventory for era stock and conquest standing requirements
    m:addOverride('xi.zones.Port_Windurst.npcs.Kumama.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BRAIS,              2194, 3 },
            { xi.item.SLOPS,               199, 3 },
            { xi.item.LEATHER_TROUSERS,    557, 2 },
            { xi.item.COTTON_BRAIS,      11232, 2 },
            { xi.item.LINEN_SLOPS,        2620, 1 },
            { xi.item.GAITERS,            1466, 3 },
            { xi.item.ASH_CLOGS,           128, 3 },
            { xi.item.LEATHER_HIGHBOOTS,   349, 2 },
            { xi.item.SOLEA,               629, 2 },
            { xi.item.COTTON_GAITERS,     7496, 2 },
            { xi.item.HOLLY_CLOGS,        1690, 1 },
            { xi.item.LAUAN_SHIELD,        124, 3 },
            { xi.item.MAPLE_SHIELD,        629, 2 },
            { xi.item.MAHOGANY_SHIELD,    5179, 1 },
        }

        player:showText(npc, zones[xi.zone.PORT_WINDURST].text.KUMAMA_SHOP_DIALOG)
        xi.shop.nation(player, stock, xi.nation.WINDURST)
    end)
end

return m
