-----------------------------------
-- Kazham Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('kazham_vendors_adjust', xi.pre(xi.expansion.ABYSSEA))

-- Toji Mumosulah: Removes OOE spell scrolls from stock
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Kazham.npcs.Toji_Mumosulah.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.YELLOW_JAR,                 496 },
        { xi.item.BLOOD_STONE,                104 },
        { xi.item.FANG_NECKLACE,             3816 },
        { xi.item.BONE_EARRING,              1812 },
        { xi.item.GEMSHORN,                  5160 },
        { xi.item.PEELED_CRAYFISH,             71 },
        { xi.item.BALL_OF_INSECT_PASTE,        40 },
        { xi.item.JUG_OF_FISH_BROTH,          179 },
        { xi.item.JUG_OF_SEEDBED_SOIL,        755 },
        { xi.item.HATCHET,                    500 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_III, 3600 },
        { xi.item.SCROLL_OF_ARMYS_PAEON_II,   357 },
    }

    if not xi.pre(xi.expansion.WOTG) then
        table.insert(stock, { xi.item.SCROLL_OF_MONOMI_ICHI, 9590 })
    end

    player:showText(npc, zones[xi.zone.KAZHAM].text.TOJIMUMOSULAH_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end)

-- Ghemi Sinterilo: Removes OOE stock Aquilaria Log and Kazham Waystone
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Kazham.npcs.Ghemi_Sinterilo.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.BUNCH_OF_PAMAMAS,         80 },
        { xi.item.KAZHAM_PINEAPPLE,         60 },
        { xi.item.MITHRAN_TOMATO,           40 },
        { xi.item.BUNCH_OF_KAZHAM_PEPPERS,  60 },
        { xi.item.STICK_OF_CINNAMON,       260 },
        { xi.item.KUKURU_BEAN,             120 },
        { xi.item.ELSHIMO_COCONUT,         172 },
    }

    if not xi.pre(xi.expansion.WOTG) then
        table.insert(stock, { xi.item.ELSHIMO_PACHIRA_FRUIT, 168 })
    end

    player:showText(npc, zones[xi.zone.KAZHAM].text.GHEMISENTERILO_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end)

-- Mamerie: Rework broth prices for in era values
-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Kazham.npcs.Mamerie.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS,       68 },
        { xi.item.CHOCOBO_FEATHER,               8 },
        { xi.item.PET_FOOD_ALPHA_BISCUIT,       11 },
        { xi.item.PET_FOOD_BETA_BISCUIT,        90 },
        { xi.item.JUG_OF_CARROT_BROTH,          90 },
        { xi.item.JUG_OF_BUG_BROTH,            756 },
        { xi.item.JUG_OF_HERBAL_BROTH,         138 },
        { xi.item.JUG_OF_CARRION_BROTH,        756 },
        { xi.item.SCROLL_OF_CHOCOBO_MAZURKA, 55200 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.MAMERIE_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end)
