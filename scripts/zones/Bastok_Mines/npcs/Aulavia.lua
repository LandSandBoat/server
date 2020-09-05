-----------------------------------
-- Area: Bastok Mines
--  NPC: Aulavia
-- Vollbow Regional Merchant
-----------------------------------
require("scripts/globals/events/harvest_festivals")
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.VOLLBOW) ~= tpz.nation.BASTOK then
        player:showText(npc, ID.text.AULAVIA_CLOSED_DIALOG)
    else
        local stock =
        {
            636,   119,    -- Chamomile
            864,    88,    -- Fish Scales
            936,    14,    -- Rock Salt
            1410, 1656,     -- Sweet William
        }

        player:showText(npc, ID.text.AULAVIA_OPEN_DIALOG)
        tpz.shop.general(player, stock, BASTOK)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
