-----------------------------------
-- Area: Port Windurst
--  NPC: Lebondur
-- Vollbow Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.VOLLBOW) ~= tpz.nation.WINDURST then
        player:showText(npc, ID.text.LEBONDUR_CLOSED_DIALOG)
    else
        local stock =
        {
            636,   119,    -- Chamomile
            864,    88,    -- Fish Scales
            936,    14,    -- Rock Salt
            1410, 1656,    -- Sweet William
        }

        player:showText(npc, ID.text.LEBONDUR_OPEN_DIALOG)
        tpz.shop.general(player, stock, WINDURST)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
