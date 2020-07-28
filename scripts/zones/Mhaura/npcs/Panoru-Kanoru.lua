----------------------------------
-- Area: Mhaura
--  NPC: Panoru-Kanoru
-- Type: Item Deliverer
-- !pos 5.241    -4.035    93.891 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.PANORU_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
