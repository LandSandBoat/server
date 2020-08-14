-----------------------------------
-- Area: Bastok_Mines
--  NPC: Mille
-- Norvallen Regional Merchant
-----------------------------------
require("scripts/globals/events/harvest_festivals")
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.NORVALLEN) ~= tpz.nation.BASTOK then
        player:showText(npc, ID.text.MILLE_CLOSED_DIALOG)
    else
        local stock =
        {
            688, 18,    -- Arrowwood Log
            698, 88,    -- Ash Log
            618, 25,    -- Blue Peas
            621, 25,     -- Crying Mustard
        }

        player:showText(npc, ID.text.MILLE_OPEN_DIALOG)
        tpz.shop.general(player, stock, BASTOK)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
