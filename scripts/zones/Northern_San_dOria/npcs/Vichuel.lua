-----------------------------------
--      Area: Northern San d'Oria
--      NPC: Vichuel
--      Only sells when San d'Oria controlls Fauregandi Region
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.FAUREGANDI) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.VICHUEL_CLOSED_DIALOG)
    else
        local stock =
        {
            4571, 90,    -- Beaugreens
            4363, 39,    -- Faerie Apple
            691,  54,    -- Maple Log
        }

        player:showText(npc, ID.text.VICHUEL_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
