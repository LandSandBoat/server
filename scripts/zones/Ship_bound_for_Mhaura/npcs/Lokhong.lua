-----------------------------------
-- Area: Ship bound for Mhaura
--  NPC: Lokhong
-- Type: Guild Merchant: Fishing Guild
-- !pos 1.841 -2.101 -9.000 221
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Ship_bound_for_Mhaura/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(521, 1, 23, 5)) then
        player:showText(npc, ID.text.LOKHONG_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
