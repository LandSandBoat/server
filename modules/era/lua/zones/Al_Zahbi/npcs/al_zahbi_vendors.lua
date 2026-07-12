-----------------------------------
-- Al Zahbi Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'al_zahbi_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('WOTG') then
    -- Zafif: Remove Reprisal
    m:addOverride('xi.zones.Al_Zahbi.npcs.Zafif.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_CURE_IV,      23400 },
            { xi.item.SCROLL_OF_CURAGA_II,    11200 },
            { xi.item.SCROLL_OF_CURAGA_III,   19932 },
            { xi.item.SCROLL_OF_PROTECT_III,  32000 },
            { xi.item.SCROLL_OF_PROTECT_IV,   91116 },
            { xi.item.SCROLL_OF_PROTECTRA_IV, 85500 },
            { xi.item.SCROLL_OF_HOLY,         35000 },
            { xi.item.SCROLL_OF_BANISHGA_II,  20000 },
            { xi.item.SCROLL_OF_SILENA,        2330 },
            { xi.item.SCROLL_OF_STONA,        19200 },
            { xi.item.SCROLL_OF_VIRUNA,       13300 },
            { xi.item.SCROLL_OF_CURSNA,        8586 },
            { xi.item.SCROLL_OF_DISPEL,       77600 },
            { xi.item.SCROLL_OF_FLASH,        27000 },
            { xi.item.SCROLL_OF_RERAISE_III,  99375 },
        }

        player:showText(npc, zones[xi.zone.AL_ZAHBI].text.ZAFIF_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)

    -- Chayaya: Removes OOE Corsair rolls added to shop inventory in the WotG era
    m:addOverride('xi.zones.Al_Zahbi.npcs.Chayaya.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.DART,               10 },
            { xi.item.HAWKEYE,            60 },
            { xi.item.GRENADE,          1204 },
            { xi.item.IRON_ARROW,          8 },
            { xi.item.WARRIOR_DIE,     68000 },
            { xi.item.MONK_DIE,        22400 },
            { xi.item.WHITE_MAGE_DIE,   5000 },
            { xi.item.BLACK_MAGE_DIE, 108000 },
            { xi.item.RED_MAGE_DIE,    62000 },
            { xi.item.THIEF_DIE,       50400 },
            { xi.item.PALADIN_DIE,     90750 },
            { xi.item.DARK_KNIGHT_DIE,  2205 },
            { xi.item.BEASTMASTER_DIE, 26600 },
            { xi.item.BARD_DIE,        12780 },
            { xi.item.RANGER_DIE,       1300 },
        }

        player:showText(npc, zones[xi.zone.AL_ZAHBI].text.CHAYAYA_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)
end

return m
