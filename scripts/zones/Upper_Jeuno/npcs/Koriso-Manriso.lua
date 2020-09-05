----------------------------------
-- Area: Upper Jeuno
--  NPC: Koriso-Manriso
-- Type: Item Deliverer
-- !pos -64.39 1 23.704 244
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
