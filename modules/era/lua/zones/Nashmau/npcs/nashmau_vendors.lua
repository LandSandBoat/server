-----------------------------------
-- Nashmau Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'nashmau_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('SOA') then
    -- Yoyoroon: Removes many PUP attachments
    m:addOverride('xi.zones.Nashmau.npcs.Yoyoroon.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.TENSION_SPRING,   4940 },
            { xi.item.LOUDSPEAKER,      4940 },
            { xi.item.ACCELERATOR,      4940 },
            { xi.item.ARMOR_PLATE,      4940 },
            { xi.item.STABILIZER,       4940 },
            { xi.item.MANA_JAMMER,      4940 },
            { xi.item.AUTO_REPAIR_KIT,  4940 },
            { xi.item.MANA_TANK,        4940 },
            { xi.item.INHIBITOR,        9925 },
            { xi.item.MANA_BOOSTER,     9925 },
            { xi.item.SCOPE,            9925 },
            { xi.item.SHOCK_ABSORBER,   9925 },
            { xi.item.VOLT_GUN,         9925 },
            { xi.item.STEALTH_SCREEN,   9925 },
            { xi.item.DAMAGE_GAUGE,     9925 },
            { xi.item.MANA_CONSERVER,   9925 },
        }

        player:showText(npc, zones[xi.zone.NASHMAU].text.YOYOROON_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)

    -- Pipiroon: Remove Nashmau Waystone from stock
    m:addOverride('xi.zones.Nashmau.npcs.Pipiroon.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.GRENADE,           1204 },
            { xi.item.RIOT_GRENADE,      6000 },
            { xi.item.PINCH_OF_BOMB_ASH,  515 },
        }

        player:showText(npc, zones[xi.zone.NASHMAU].text.PIPIROON_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)
end

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Mamaroon: Remove Scroll of Enlight and Scroll of Endark from stock
    m:addOverride('xi.zones.Nashmau.npcs.Mamaroon.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_STUN,          27000 },
            { xi.item.SCROLL_OF_ENFIRE,         5160 },
            { xi.item.SCROLL_OF_ENBLIZZARD,     4098 },
            { xi.item.SCROLL_OF_ENAERO,         2500 },
            { xi.item.SCROLL_OF_ENSTONE,        2030 },
            { xi.item.SCROLL_OF_ENTHUNDER,      1515 },
            { xi.item.SCROLL_OF_ENWATER,        7074 },
            { xi.item.SCROLL_OF_SHOCK_SPIKES,   9000 },
            { xi.item.WHITE_PUPPET_TURBAN,     29950 },
            { xi.item.BLACK_PUPPET_TURBAN,     29950 },
        }

        player:showText(npc, zones[xi.zone.NASHMAU].text.MAMAROON_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)

    -- Jajaroon: Removes Trump Card Case added in Abyssea
    m:addOverride('xi.zones.Nashmau.npcs.Jajaroon.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.FIRE_CARD,           48 },
            { xi.item.ICE_CARD,            48 },
            { xi.item.WIND_CARD,           48 },
            { xi.item.EARTH_CARD,          48 },
            { xi.item.THUNDER_CARD,        48 },
            { xi.item.WATER_CARD,          48 },
            { xi.item.LIGHT_CARD,          48 },
            { xi.item.DARK_CARD,           48 },
            { xi.item.SAMURAI_DIE,      35200 },
            { xi.item.NINJA_DIE,          600 },
            { xi.item.DRAGOON_DIE,       9216 },
            { xi.item.SUMMONER_DIE,     40000 },
            { xi.item.BLUE_MAGE_DIE,     3525 },
            { xi.item.CORSAIR_DIE,        316 },
            { xi.item.PUPPETMASTER_DIE, 82500 },
        }

        player:showText(npc, zones[xi.zone.NASHMAU].text.JAJAROON_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)
end

return m
