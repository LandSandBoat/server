----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Maturiri
-- Type: Item Deliverer
-- !pos -77.366 -20 -71.128 26
--
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
