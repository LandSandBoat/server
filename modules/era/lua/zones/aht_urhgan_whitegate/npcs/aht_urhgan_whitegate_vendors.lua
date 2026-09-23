-----------------------------------
-- Aht Urhgan Whitegate Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('aht_urhgan_whitegate_vendors_adjust')

m:addOverrideByEra('xi.zones.Aht_Urhgan_Whitegate.npcs.Dwago.onTrigger', {
    [xi.expansion.ABYSSEA] = function(player, npc)
        local stock =
        {
            { xi.item.LUGWORM,                 12 },
            { xi.item.LITTLE_WORM,              4 },
            { xi.item.PET_FOOD_ALPHA_BISCUIT,  12 },
            { xi.item.PET_FOOD_BETA_BISCUIT,   93 },
            { xi.item.JUG_OF_BUG_BROTH,       786 },
        }

        player:showText(npc, zones[xi.zone.AHT_URHGAN_WHITEGATE].text.DWAGO_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end,
})

-- Gavrie: Remove Automaton Oil +3 from shop inventory
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.zones.Aht_Urhgan_Whitegate.npcs.Gavrie.onTrigger', {
    [xi.expansion.ABYSSEA] = function(player, npc)
        local stock =
        {
            { xi.item.FLASK_OF_EYE_DROPS,        2595 },
            { xi.item.ANTIDOTE,                   316 },
            { xi.item.FLASK_OF_ECHO_DROPS,        800 },
            { xi.item.POTION,                     910 },
            { xi.item.ETHER,                     4832 },
            { xi.item.REMEDY,                   22400 },
            { xi.item.FLASK_OF_DISTILLED_WATER,    12 },
            { xi.item.CAN_OF_AUTOMATON_OIL,       200 },
            { xi.item.CAN_OF_AUTOMATON_OIL_P1,    500 },
            { xi.item.CAN_OF_AUTOMATON_OIL_P2,   1000 },
        }

        player:showText(npc, zones[xi.zone.AHT_URHGAN_WHITEGATE].text.GAVRIE_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end,
})

m:addOverrideByEra('xi.zones.Aht_Urhgan_Whitegate.npcs.Hagakoff.onTrigger', {
    [xi.expansion.ABYSSEA] = function(player, npc)
        local stock =
        {
            { xi.item.KATARS,            15488, astralCandescence = true  },
            { xi.item.DARKSTEEL_KATARS,  67760, astralCandescence = false },
            { xi.item.PATAS,             45760, astralCandescence = true  },
            { xi.item.BRONZE_DAGGER,       156, astralCandescence = false },
            { xi.item.DAGGER,             2030, astralCandescence = true  },
            { xi.item.SAPARA,              776, astralCandescence = false },
            { xi.item.SCIMITAR,           4525, astralCandescence = false },
            { xi.item.TULWAR,            38800, astralCandescence = true  },
            { xi.item.TABAR,             66000, astralCandescence = false },
            { xi.item.DARKSTEEL_TABAR,  124305, astralCandescence = true  },
            { xi.item.BUTTERFLY_AXE,       672, astralCandescence = false },
            { xi.item.GREATAXE,           4550, astralCandescence = true  },
            { xi.item.BRONZE_ZAGHNAL,      344, astralCandescence = false },
            { xi.item.ZAGHNAL,           12540, astralCandescence = true  },
            { xi.item.ASH_CLUB,             72, astralCandescence = false },
            { xi.item.CHESTNUT_CLUB,      1740, astralCandescence = true  },
            { xi.item.ANGON,               238, astralCandescence = false },
        }

        player:showText(npc, zones[xi.zone.AHT_URHGAN_WHITEGATE].text.HAGAKOFF_SHOP_DIALOG)
        xi.besieged.shop(player, stock)
    end,
})

-- Mazween: Absorb-ACC requires WOTG
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.zones.Aht_Urhgan_Whitegate.npcs.Mazween.onTrigger', {
    [xi.expansion.ABYSSEA] = function(player, npc)
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

        if not xi.pre(xi.expansion.WOTG) then
            table.insert(stock, { xi.item.SCROLL_OF_ABSORB_ACC, 44000 })
        end

        player:showText(npc, zones[xi.zone.AHT_URHGAN_WHITEGATE].text.MAZWEEN_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end,
})

-- Khaf Jhifanm: Remove Empire Waystone from stock
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.zones.Aht_Urhgan_Whitegate.npcs.Khaf_Jhifanm.onTrigger', {
    [xi.expansion.SOA] = function(player, npc)
        local stock =
        {
            { xi.item.DRIED_DATE,                200 },
            { xi.item.FLASK_OF_AYRAN,             800 },
            { xi.item.BALIK_SANDVICI,            3750 },
            { xi.item.BAG_OF_WILDGRASS_SEEDS,     320 },
            { xi.item.SCROLL_OF_RAPTOR_MAZURKA,  4500 },
        }

        player:showText(npc, zones[xi.zone.AHT_URHGAN_WHITEGATE].text.KHAFJHIFANM_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end,
})
