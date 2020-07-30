-----------------------------------
-- Area: Port San d'Oria
--  NPC: Patolle
-- Kuzotz Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.KUZOTZ) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.PATOLLE_CLOSED_DIALOG)
    else
        local stock =
        {
            916,  855,    -- Cactuar Needle
            4412, 299,    -- Thundermelon
            4491, 184,    -- Watermelon
        }

        player:showText(npc, ID.text.PATOLLE_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
