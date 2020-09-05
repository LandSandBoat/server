----------------------------------
-- Area: Rabao
--  NPC: Pakhi Churhebi
-- Type: Item Deliverer
-- !pos 158.428 7.999 78.009 247
--
-----------------------------------
local ID = require("scripts/zones/Rabao/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.PAKHI_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
