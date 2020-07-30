----------------------------------
-- Area: Port Jeuno
--  NPC: Digaga
-- Type: Item Deliverer
-- !pos -52.865 7.999 1.134 246
--
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
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
