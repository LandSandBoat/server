-----------------------------------
-- Aht Urhgan Whitegate Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'aht_urhgan_whitegate_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Gavrie: Remove Automaton Oil +3 from shop inventory
    m:addOverride('xi.zones.Aht_Urhgan_Whitegate.npcs.Gavrie.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.FLASK_OF_EYE_DROPS,     2595 },
            { xi.item.ANTIDOTE,                316 },
            { xi.item.FLASK_OF_ECHO_DROPS,     800 },
            { xi.item.POTION,                  910 },
            { xi.item.ETHER,                  4832 },
            { xi.item.REMEDY,                 3360 },
            { xi.item.FLASK_OF_DISTILLED_WATER, 12 },
            { xi.item.CAN_OF_AUTOMATON_OIL,     50 },
            { xi.item.CAN_OF_AUTOMATON_OIL_P1, 250 },
            { xi.item.CAN_OF_AUTOMATON_OIL_P2, 500 },
        }

        player:showText(npc, zones[xi.zone.AHT_URHGAN_WHITEGATE].text.GAVRIE_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)

    -- Mazween: Absorb-ACC requires WOTG
    m:addOverride('xi.zones.Aht_Urhgan_Whitegate.npcs.Mazween.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_SLEEPGA,      11200 },
            { xi.item.SCROLL_OF_SLEEP_II,     18720 },
            { xi.item.SCROLL_OF_POISON_II,    25200 },
            { xi.item.SCROLL_OF_BIO_II,       14000 },
            { xi.item.SCROLL_OF_POISONGA,      5160 },
            { xi.item.SCROLL_OF_STONE_III,    19932 },
            { xi.item.SCROLL_OF_WATER_III,    22682 },
            { xi.item.SCROLL_OF_AERO_III,     27744 },
            { xi.item.SCROLL_OF_FIRE_III,     33306 },
            { xi.item.SCROLL_OF_BLIZZARD_III, 39368 },
            { xi.item.SCROLL_OF_THUNDER_III,  45930 },
            { xi.item.SCROLL_OF_ABSORB_TP,    27000 },
            { xi.item.SCROLL_OF_DRAIN_II,     30780 },
            { xi.item.SCROLL_OF_DREAD_SPIKES, 70560 },
        }

        if xi.module.isContentEnabled('WOTG') then
            table.insert(stock, { xi.item.SCROLL_OF_ABSORB_ACC, 44000 })
        end

        player:showText(npc, zones[xi.zone.AHT_URHGAN_WHITEGATE].text.MAZWEEN_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)
end

if not xi.module.isContentEnabled('SOA') then
    -- Khaf Jhifanm: Remove Empire Waystone from stock
    m:addOverride('xi.zones.Aht_Urhgan_Whitegate.npcs.Khaf_Jhifanm.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.DRIED_DATE,                200 },
            { xi.item.FLASK_OF_AYRAN,             800 },
            { xi.item.BALIK_SANDVICI,            3750 },
            { xi.item.BAG_OF_WILDGRASS_SEEDS,     320 },
            { xi.item.SCROLL_OF_RAPTOR_MAZURKA,  4400 },
        }

        player:showText(npc, zones[xi.zone.AHT_URHGAN_WHITEGATE].text.KHAFJHIFANM_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)
end

return m
