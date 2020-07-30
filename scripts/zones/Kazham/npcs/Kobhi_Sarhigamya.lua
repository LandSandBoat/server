----------------------------------
-- Area: Kazham
--  NPC: Kobhi Sarhigamya
-- Type: Item Deliverer
-- !pos -115.29 -11 -22.609 250
--
-----------------------------------
local ID = require("scripts/zones/Kazham/IDs")
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
