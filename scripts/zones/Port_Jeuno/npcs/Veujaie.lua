----------------------------------
-- Area: Port Jeuno
--  NPC: Veujaie
-- Type: Item Deliverer
-- !pos -20.349 7.999 -2.888 246
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
