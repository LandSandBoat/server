-----------------------------------
-- Area: Southern San dOria
--  NPC: Lanqueron
-- Type: Item Deliverer NPC
-- Involved in Quest: Lost Chick
-- !pos 0.335 1.199 -28.404 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
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
