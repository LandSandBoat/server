-----------------------------------
-- Upper Jeuno Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('upper_jeuno_vendors_adjust', xi.pre(xi.expansion.ROV))

-- Antonia: Remove job point related weapons from stock
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Upper_Jeuno.npcs.Antonia.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.MYTHRIL_ROD,   6256 },
        { xi.item.OAK_CUDGEL,   11232 },
        { xi.item.MYTHRIL_MACE, 18048 },
        { xi.item.WARHAMMER,     6558 },
        { xi.item.OAK_POLE,     37440 },
        { xi.item.HALBERD,      44550 },
        { xi.item.SCYTHE,       10596 },
        { xi.item.IRON_ARROW,      10 },
    }

    player:showText(npc, zones[xi.zone.UPPER_JEUNO].text.VIETTES_SHOP_DIALOG)
    xi.shop.general(player, stock)
end)

-- Coumuna: Remove polearm/blunt weapons (belong to Antonia's stock) and Mythril Axe
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Upper_Jeuno.npcs.Coumuna.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.MYTHRIL_CLAWS,    29760 },
        { xi.item.KATARS,           15488 },
        { xi.item.MYTHRIL_KNIFE,    14560 },
        { xi.item.KRIS,             12096 },
        { xi.item.MYTHRIL_DEGEN,    31000 },
        { xi.item.KNIGHTS_SWORD,    85250 },
        { xi.item.TWO_HANDED_SWORD, 13926 },
        { xi.item.GREATAXE,          4550 },
    }

    player:showText(npc, zones[xi.zone.UPPER_JEUNO].text.VIETTES_SHOP_DIALOG)
    xi.shop.general(player, stock)
end)

-- Areebah: Remove items not sold in this era
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Upper_Jeuno.npcs.Areebah.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.CHAMOMILE,   130 },
        { xi.item.WIJNRUIT,    120 },
        { xi.item.CARNATION,    60 },
        { xi.item.RED_ROSE,     80 },
        { xi.item.RAIN_LILY,    96 },
        { xi.item.LILAC,       120 },
        { xi.item.AMARYLLIS,   120 },
        { xi.item.MARGUERITE,  120 },
    }

    -- Add Water Lily to stock if Abyssea is enabled
    if not xi.pre(xi.expansion.ABYSSEA) then
        table.insert(stock, { xi.item.WATER_LILY, 630 })
    end

    -- Add Flower Seeds to stock if WOTG is enabled
    if not xi.pre(xi.expansion.WOTG) then
        table.insert(stock, { xi.item.BAG_OF_FLOWER_SEEDS, 520 })
    end

    player:showText(npc, zones[xi.zone.UPPER_JEUNO].text.MP_SHOP_DIALOG)
    xi.shop.general(player, stock)
end)
