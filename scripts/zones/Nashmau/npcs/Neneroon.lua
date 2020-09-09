----------------------------------
-- Area: Nashmau
--  NPC: Neneroon
-- Type: Item Deliverer
-- !pos -0.866    -5.999    36.942 53
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.NENE_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
