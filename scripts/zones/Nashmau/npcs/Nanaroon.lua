----------------------------------
-- Area: Nashmau
--  NPC: Nanaroon
-- Type: Item Deliverer
-- !pos -2.404    -6    37.141 53
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.NANA_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
