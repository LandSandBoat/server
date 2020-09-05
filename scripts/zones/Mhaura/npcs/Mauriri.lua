----------------------------------
-- Area: Mhaura
--  NPC: Mauriri
-- Type: Item Deliverer
-- !pos 10.883    -15.99    66.186 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.MAURIRI_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
