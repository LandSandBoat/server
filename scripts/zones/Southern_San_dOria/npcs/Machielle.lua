-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Machielle
-- Norvallen Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.NORVALLEN) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.MACHIELLE_CLOSED_DIALOG)
    else
        local stock =
        {
            688, 18,    -- Arrowwood Log
            621, 25,    -- Crying Mustard
            618, 25,    -- Blue Peas
            698, 88,    -- Ash Log
        }

        player:showText(npc, ID.text.MACHIELLE_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
