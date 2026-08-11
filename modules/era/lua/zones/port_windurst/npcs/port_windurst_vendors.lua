-----------------------------------
-- Port Windurst Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('port_windurst_vendors_adjust', xi.pre(xi.expansion.ABYSSEA))

-- Hohbiba-Mubiba: Rework inventory for era stock and conquest standing requirements
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Port_Windurst.npcs.Hohbiba-Mubiba.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.MAPLE_WAND,           52, 3 },
        { xi.item.WILLOW_WAND,         370, 2 },
        { xi.item.YEW_WAND,           1566, 1 },
        { xi.item.BRONZE_ROD,          100, 1 },
        { xi.item.ASH_CLUB,             72, 3 },
        { xi.item.CHESTNUT_CLUB,      1740, 3 },
        { xi.item.BONE_CUDGEL,        5376, 2 },
        { xi.item.ASH_STAFF,            63, 3 },
        { xi.item.HOLLY_STAFF,         635, 2 },
        { xi.item.ELM_STAFF,          3606, 1 },
        { xi.item.ASH_POLE,            420, 3 },
        { xi.item.HOLLY_POLE,         5076, 2 },
        { xi.item.ELM_POLE,          18240, 1 },
        { xi.item.BRONZE_DAGGER,       156, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.HOHBIBAMUBIBA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end)

-- Taniko-Maniko: Rework inventory for era stock and conquest standing requirements
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Port_Windurst.npcs.Taniko-Maniko.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.CAT_BAGHNAKHS,       116, 2 },
        { xi.item.CESTI,               144, 2 },
        { xi.item.BONE_AXE,           4665, 3 },
        { xi.item.BONE_PICK,          6516, 2 },
        { xi.item.BRONZE_ZAGHNAL,      344, 3 },
        { xi.item.BRASS_ZAGHNAL,      2825, 1 },
        { xi.item.HARPOON,             108, 3 },
        { xi.item.WRAPPED_BOW,        7920, 1 },
        { xi.item.ICE_ARROW,           140, 1 },
        { xi.item.LIGHTNING_ARROW,     140, 1 },
        { xi.item.SELF_BOW,            536, 2 },
        { xi.item.WOODEN_ARROW,          4, 2 },
        { xi.item.HAWKEYE,              61, 2 },
        { xi.item.BOOMERANG,          1750, 2 },
        { xi.item.SHORTBOW,             43, 3 },
        { xi.item.BONE_ARROW,            5, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.TANIKOMANIKO_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end)

-- Guruna-Maguruna: Rework inventory for era stock and conquest standing requirements
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Port_Windurst.npcs.Guruna-Maguruna.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.HEMP_GORGET,        1080, 3 },
        { xi.item.BEETLE_GORGET,      4668, 1 },
        { xi.item.DOUBLET,            2745, 3 },
        { xi.item.ROBE,                240, 3 },
        { xi.item.LEATHER_VEST,        672, 3 },
        { xi.item.TUNIC,              1400, 2 },
        { xi.item.COTTON_DOUBLET,    13728, 2 },
        { xi.item.LINEN_ROBE,         3085, 1 },
        { xi.item.GLOVES,             1515, 3 },
        { xi.item.CUFFS,               132, 3 },
        { xi.item.LEATHER_GLOVES,      360, 2 },
        { xi.item.MITTS,               655, 2 },
        { xi.item.COTTON_GLOVES,      7440, 2 },
        { xi.item.LINEN_CUFFS,        1745, 1 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.GURUNAMAGURUNA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end)

-- Kumama: Rework inventory for era stock and conquest standing requirements
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Port_Windurst.npcs.Kumama.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.BRAIS,              2110, 3 },
        { xi.item.SLOPS,               192, 3 },
        { xi.item.LEATHER_TROUSERS,    536, 2 },
        { xi.item.COTTON_BRAIS,      10800, 2 },
        { xi.item.LINEN_SLOPS,        2520, 1 },
        { xi.item.GAITERS,            1410, 3 },
        { xi.item.ASH_CLOGS,           124, 3 },
        { xi.item.LEATHER_HIGHBOOTS,   336, 2 },
        { xi.item.SOLEA,               605, 2 },
        { xi.item.COTTON_GAITERS,     7208, 2 },
        { xi.item.HOLLY_CLOGS,        1625, 1 },
        { xi.item.LAUAN_SHIELD,        120, 3 },
        { xi.item.MAPLE_SHIELD,        605, 2 },
        { xi.item.MAHOGANY_SHIELD,    4980, 1 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.KUMAMA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end)
