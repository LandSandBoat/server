-----------------------------------
-- Area: Windurst Waters
--  NPC: Ahyeekih
-- Only sells when Windurst controls Kolshushu
-- Confirmed shop stock, August 2013
-----------------------------------
require("scripts/globals/events/harvest_festivals")
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
    local RegionOwner = GetRegionOwner(tpz.region.KOLSHUSHU)
    if (RegionOwner ~= tpz.nation.WINDURST) then
        player:showText(npc, ID.text.AHYEEKIH_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.AHYEEKIH_OPEN_DIALOG)

        local stock =
        {
            4503,   184,  -- Buburimu Grape
            1120,  1620,  -- Casablanca
            4359,   220,  -- Dhalmel Meat
            614,     72,  -- Mhaura Garlic
            4445,    40   -- Yagudo Cherry
        }
        tpz.shop.general(player, stock, WINDURST)

    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
