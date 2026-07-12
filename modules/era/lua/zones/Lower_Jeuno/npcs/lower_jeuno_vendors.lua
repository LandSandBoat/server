-----------------------------------
-- Lower Jeuno Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'lower_jeuno_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('SOA') then
    -- Pawkrix: Remove Bowl of Goblin Stew 880 from stock
    m:addOverride('xi.zones.Lower_Jeuno.npcs.Pawkrix.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BAG_OF_HORO_FLOUR,           40 },
            { xi.item.LOAF_OF_GOBLIN_BREAD,       300 },
            { xi.item.GOBLIN_PIE,                  650 },
            { xi.item.CHUNK_OF_GOBLIN_CHOCOLATE,   35 },
            { xi.item.GOBLIN_MUSHPOT,             1140 },
            { xi.item.BAG_OF_POISON_FLOUR,         515 },
            { xi.item.GOBLIN_DOLL,                 500 },
        }

        player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.PAWKRIX_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)
end

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Creepstix: Removes OOE spell scrolls
    m:addOverride('xi.zones.Lower_Jeuno.npcs.Creepstix.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_GOBLIN_GAVOTTE, 8160 },
            { xi.item.SCROLL_OF_PROTECTRA_II,   7074 },
            { xi.item.SCROLL_OF_SHELLRA,        1760 },
        }

        player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.JUNK_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)

    -- Hasim: Removes OOE spell scrolls
    m:addOverride('xi.zones.Lower_Jeuno.npcs.Hasim.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_CURE_IV,     23400 },
            { xi.item.SCROLL_OF_CURAGA_II,   11200 },
            { xi.item.SCROLL_OF_CURAGA_III,  19932 },
            { xi.item.SCROLL_OF_PROTECT_III, 32000 },
            { xi.item.SCROLL_OF_BARFIRE,      1760 },
            { xi.item.SCROLL_OF_BARBLIZZARD,  3624 },
            { xi.item.SCROLL_OF_BARAERO,       930 },
            { xi.item.SCROLL_OF_BARSTONE,      156 },
            { xi.item.SCROLL_OF_BARTHUNDER,   5754 },
            { xi.item.SCROLL_OF_BARWATER,      360 },
            { xi.item.SCROLL_OF_BARFIRA,      1760 },
            { xi.item.SCROLL_OF_BARBLIZZARA,  3624 },
            { xi.item.SCROLL_OF_BARAERA,       930 },
            { xi.item.SCROLL_OF_BARSTONRA,     156 },
            { xi.item.SCROLL_OF_BARTHUNDRA,   5754 },
            { xi.item.SCROLL_OF_BARWATERA,     360 },
            { xi.item.SCROLL_OF_BARSLEEP,      244 },
        }

        player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.WAAG_DEEG_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)

    -- Susu: Removes OOE spell scrolls
    m:addOverride('xi.zones.Lower_Jeuno.npcs.Susu.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_BANISHGA_II,  20000 },
            { xi.item.SCROLL_OF_BARBLIND,      2030 },
            { xi.item.SCROLL_OF_BARBLINDRA,    2030 },
            { xi.item.SCROLL_OF_BARPARALYZE,    780 },
            { xi.item.SCROLL_OF_BARPALARYZRA,   780 },
            { xi.item.SCROLL_OF_BARPOISON,      400 },
            { xi.item.SCROLL_OF_BARPOISONRA,    400 },
            { xi.item.SCROLL_OF_BARSILENCE,    4608 },
            { xi.item.SCROLL_OF_BARSILENCERA,  4608 },
            { xi.item.SCROLL_OF_BARSLEEP,       244 },
            { xi.item.SCROLL_OF_BARSLEEPRA,     244 },
            { xi.item.SCROLL_OF_CURSNA,        8586 },
            { xi.item.SCROLL_OF_HOLY,         35000 },
            { xi.item.SCROLL_OF_SILENA,        2330 },
            { xi.item.SCROLL_OF_STONA,        19200 },
            { xi.item.SCROLL_OF_VIRUNA,       13300 },
        }

        player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.WAAG_DEEG_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)

    -- Stinknix: Remove Duchy Waystone
    m:addOverride('xi.zones.Lower_Jeuno.npcs.Stinknix.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.PINCH_OF_POISON_DUST,     320 },
            { xi.item.PINCH_OF_VENOM_DUST,     1035 },
            { xi.item.PINCH_OF_PARALYSIS_DUST, 2000 },
            { xi.item.IRON_ARROW,                 8 },
            { xi.item.CROSSBOW_BOLT,              6 },
            { xi.item.GRENADE,                 1204 },
        }

        player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.JUNK_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)

    -- Taza: Add era-appropriate scroll stock
    m:addOverride('xi.zones.Lower_Jeuno.npcs.Taza.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_SLEEPGA,       10304 },
            { xi.item.SCROLL_OF_SHELL_III,     26244 },
            { xi.item.SCROLL_OF_PROTECTRA_III, 19200 },
            { xi.item.SCROLL_OF_SHELLRA_II,    14080 },
            { xi.item.SCROLL_OF_SHELLRA_III,   26244 },
            { xi.item.SCROLL_OF_BARPETRIFY,    15120 },
            { xi.item.SCROLL_OF_BARVIRUS,       9600 },
            { xi.item.SCROLL_OF_BARPETRA,      15120 },
            { xi.item.SCROLL_OF_BARVIRA,        9600 },
            { xi.item.SCROLL_OF_SLEEP_II,      18720 },
            { xi.item.SCROLL_OF_STONE_III,     19932 },
            { xi.item.SCROLL_OF_WATER_III,     22682 },
            { xi.item.SCROLL_OF_AERO_III,      27744 },
            { xi.item.SCROLL_OF_FIRE_III,      33306 },
            { xi.item.SCROLL_OF_BLIZZARD_III,  39368 },
            { xi.item.SCROLL_OF_THUNDER_III,   45930 },
        }

        player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.WAAG_DEEG_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)

    -- Yoskolo: Removed OOE Sentinels Scherzo from stock
    m:addOverride('xi.zones.Lower_Jeuno.npcs.Yoskolo.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.FLASK_OF_DISTILLED_WATER,       12 },
            { xi.item.BOTTLE_OF_ORANGE_JUICE,        200 },
            { xi.item.BOTTLE_OF_APPLE_JUICE,         300 },
            { xi.item.BOTTLE_OF_MELON_JUICE,        1100 },
            { xi.item.BOTTLE_OF_GRAPE_JUICE,         930 },
            { xi.item.BOTTLE_OF_PINEAPPLE_JUICE,     400 },
            { xi.item.SERVING_OF_ICECAP_ROLANBERRY, 5544 },
            { xi.item.SCROLL_OF_FIRE_CAROL,         6380 },
            { xi.item.SCROLL_OF_ICE_CAROL,          7440 },
            { xi.item.SCROLL_OF_WIND_CAROL,         5940 },
            { xi.item.SCROLL_OF_EARTH_CAROL,        4600 },
            { xi.item.SCROLL_OF_LIGHTNING_CAROL,    7920 },
            { xi.item.SCROLL_OF_WATER_CAROL,        5000 },
            { xi.item.SCROLL_OF_LIGHT_CAROL,        4200 },
            { xi.item.SCROLL_OF_DARK_CAROL,         8400 },
        }

        player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.YOSKOLO_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)
end

return m
