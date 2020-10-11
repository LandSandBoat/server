-----------------------------------
-- Area: Windurst Waters
--  NPC: Baehu-Faehu
-- Only sells when Windurst has control of Sarutabaruta
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local RegionOwner = GetRegionOwner(tpz.region.SARUTABARUTA)
    if (RegionOwner ~= tpz.nation.WINDURST) then
        player:showText(npc, ID.text.BAEHUFAEHU_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.BAEHUFAEHU_OPEN_DIALOG)

        local stock =
        {
            4444,  22,  -- Rarab Tail
            689,   33,  -- Lauan Log
            619,   43,  -- Popoto
            4392,  29,  -- Saruta Orange
            635,   18   -- Windurstian Tea Leaves
        }
        tpz.shop.general(player, stock, WINDURST)

    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
