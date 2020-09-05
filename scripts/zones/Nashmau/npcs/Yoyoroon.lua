-----------------------------------
-- Area: Nashmau
--  NPC: Yoyoroon
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        2239,  4940,    -- Tension Spring
        2243,  4940,    -- Loudspeaker
        2246,  4940,    -- Accelerator
        2251,  4940,    -- Armor Plate
        2254,  4940,    -- Stabilizer
        2258,  4940,    -- Mana Jammer
        2262,  4940,    -- Auto-Repair Kit
        2266,  4940,    -- Mana Tank
        2240,  9925,    -- Inhibitor
        9229,  9925,    -- Speedloader
        2242,  9925,    -- Mana Booster
        2247,  9925,    -- Scope
        2250,  9925,    -- Shock Absorber
        2255,  9925,    -- Volt Gun
        2260,  9925,    -- Stealth Screen
        2264,  9925,    -- Damage Gauge
        2268,  9925,    -- Mana Conserver
        2238, 19890,    -- Strobe
        2409, 19890,    -- Flame Holder
        2410, 19890,    -- Ice Maker
        2248, 19890,    -- Pattern Reader
        2411, 19890,    -- Replicator
        2252, 19890,    -- Analyzer
        2256, 19890,    -- Heat Seeker
        2259, 19890,    -- Heatsink
        2263, 19890,    -- Flashbulb
        2267, 19890,    -- Mana Converter
        2241, 29640,    -- Tension Spring II
        2244, 29640,    -- Scanner
        2245, 29640,    -- Loudspeaker II
        2249, 29640,    -- Accelerator II
        2253, 29640,    -- Armor Plate II
        2257, 29640,    -- Stabilizer II
        2261, 29640,    -- Mana Jammer II
        2412, 41496,    -- Hammermill
        9068, 41496,    -- Barrier Module
        9070, 41496,    -- Resister
        2265, 41496,    -- Auto-Repair Kit II
        9072, 41496,    -- Arcanic Cell
        2269, 41496,    -- Mana Tank II
        9032, 53352,    -- Strobe II
        9033, 65208,    -- Tension Spring III
        9034, 65208,    -- Loudspeaker III
        9066, 65208,    -- Amplifier
        9037, 65208,    -- Accelerator III
        9036, 65208,    -- Scope II
        9039, 65208,    -- Armor Plate III
        9040, 65208,    -- Stabilizer III
        9042, 65208,    -- Mana Jammer III
        9065, 82992,    -- Inhibitor II
        9230, 82992,    -- Speedloader II
        9067, 82992,    -- Repeater
        9043, 82992,    -- Stealth Screen II
        2322, 118560,   -- Attuner
        3307, 118560,   -- Heat Capacitor
        2323, 118560,   -- Tactical Processor
        3308, 118560,   -- Power Cooler
        2324, 118560,   -- Drum Magazine
        3309, 118560,   -- Barrage Turbine
        2325, 118560,   -- Equalizer
        3310, 118560,   -- Barrier Module II
        2326, 118560,   -- Target Marker
        3311, 118560,   -- Galvanizer
        2327, 118560,   -- Mana Channeler
        3312, 118560,   -- Percolator
        2328, 118560,   -- Eraser
        3313, 118560,   -- Vivi-Valve
        2329, 118560,   -- Smoke Screen
        3314, 118560,   -- Disruptor
    }

    player:showText(npc, ID.text.YOYOROON_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
