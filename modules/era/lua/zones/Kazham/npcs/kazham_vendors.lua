-----------------------------------
-- Kazham Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'kazham_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Toji Mumosulah: Removes OOE spell scrolls from stock
    m:addOverride('xi.zones.Kazham.npcs.Toji_Mumosulah.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.YELLOW_JAR,                 520 },
            { xi.item.BLOOD_STONE,                109 },
            { xi.item.FANG_NECKLACE,             4006 },
            { xi.item.BONE_EARRING,              1902 },
            { xi.item.GEMSHORN,                  5418 },
            { xi.item.PEELED_CRAYFISH,             73 },
            { xi.item.BALL_OF_INSECT_PASTE,        42 },
            { xi.item.JUG_OF_FISH_BROTH,          165 },
            { xi.item.JUG_OF_SEEDBED_SOIL,        695 },
            { xi.item.HATCHET,                    525 },
            { xi.item.SCROLL_OF_ARMYS_PAEON_III, 3780 },
            { xi.item.SCROLL_OF_ARMYS_PAEON_II,   328 },
        }

        if xi.module.isContentEnabled('WOTG') then
            table.insert(stock, { xi.item.SCROLL_OF_MONOMI_ICHI, 10069 })
        end

        player:showText(npc, zones[xi.zone.KAZHAM].text.TOJIMUMOSULAH_SHOP_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end)

    -- Ghemi Sinterilo: Removes OOE stock Aquilaria Log and Kazham Waystone
    m:addOverride('xi.zones.Kazham.npcs.Ghemi_Sinterilo.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BUNCH_OF_PAMAMAS,         84 },
            { xi.item.KAZHAM_PINEAPPLE,         63 },
            { xi.item.MITHRAN_TOMATO,           42 },
            { xi.item.BUNCH_OF_KAZHAM_PEPPERS,  63 },
            { xi.item.STICK_OF_CINNAMON,       273 },
            { xi.item.KUKURU_BEAN,             126 },
            { xi.item.ELSHIMO_COCONUT,         180 },
        }

        if xi.module.isContentEnabled('WOTG') then
            table.insert(stock, { xi.item.ELSHIMO_PACHIRA_FRUIT, 176 })
        end

        player:showText(npc, zones[xi.zone.KAZHAM].text.GHEMISENTERILO_SHOP_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end)
end

return m
