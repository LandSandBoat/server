-----------------------------------
-- Area: Port Windurst
--  NPC: Zoreen
-- Valdeaunia Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.VALDEAUNIA) ~= tpz.nation.WINDURST then
        player:showText(npc, ID.text.ZOREEN_CLOSED_DIALOG)
    else
        local stock =
        {
            4382, 29,    -- Frost Turnip
            638, 170,    -- Sage
        }

        player:showText(npc, ID.text.ZOREEN_OPEN_DIALOG)
        tpz.shop.general(player, stock, WINDURST)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
