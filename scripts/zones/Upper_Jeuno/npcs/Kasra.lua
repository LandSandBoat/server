----------------------------------
-- Area: Upper Jeuno
--  NPC: Kasra
-- Type: Item Deliverer
-- !pos -34.555 7.999 90.702 244
--
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
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
