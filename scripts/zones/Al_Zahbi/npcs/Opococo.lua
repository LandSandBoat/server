----------------------------------
-- Area: Al Zahbi
--  NPC: Opococo
-- Type: Item Deliverer
-- !pos -24.702 0 -139.982 48
-----------------------------------
local ID = require("scripts/zones/Al_Zahbi/IDs")
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
