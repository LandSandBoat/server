-----------------------------------
-- Area: Windurst Waters
--  NPC: Maqu Molpih
-- Only sells when Windurst controlls Aragoneu Region
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
    local RegionOwner = GetRegionOwner(tpz.region.ARAGONEU)
    if (RegionOwner ~= tpz.nation.WINDURST) then
        player:showText(npc, ID.text.MAQUMOLPIH_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.MAQUMOLPIH_OPEN_DIALOG)

        local stock =
        {
            631,    36,  -- Horo Flour
            629,    44,  -- Millioncorn
            4415,  114,  -- Roasted Corn
            4505,   92,  -- Sunflower Seeds
            841,    36   -- Yagudo Feather
        }
        tpz.shop.general(player, stock, WINDURST)

    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
