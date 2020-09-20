-----------------------------------
-- Area: Port Windurst
--  NPC: Sheia Pohrichamaha
-- Fauregandi Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.FAUREGANDI) ~= tpz.nation.WINDURST then
        player:showText(npc, ID.text.SHEIAPOHRICHAMAHA_CLOSED_DIALOG)
    else
        local stock =
        {
            4571, 90,    -- Beaugreens
            4363, 39,    -- Faerie Apple
            691,  54,    -- Maple Log
        }

        player:showText(npc, ID.text.SHEIAPOHRICHAMAHA_OPEN_DIALOG)
        tpz.shop.general(player, stock, WINDURST)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
