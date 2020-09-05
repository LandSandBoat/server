-----------------------------------
-- Area: Windurst_Waters
--  NPC: Otete
-- Only sells when Windurst controlls Li'Telor Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local RegionOwner = GetRegionOwner(tpz.region.LITELOR)
    if (RegionOwner ~= tpz.nation.WINDURST) then
        player:showText(npc, ID.text.OTETE_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.OTETE_OPEN_DIALOG)

        local stock =
        {
            623,    119, -- Bay Leaves
            4154,  6440  -- Holy Water
        }
        tpz.shop.general(player, stock, WINDURST)

    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
