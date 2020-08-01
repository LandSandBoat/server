----------------------------------
-- Area: Lower Jeuno
--  NPC: Subash
-- Type: Item Deliverer
-- !pos -19.84 -0.101 -38.081 245
--
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
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
