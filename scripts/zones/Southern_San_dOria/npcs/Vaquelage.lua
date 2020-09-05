-----------------------------------
-- Area: Southern San dOria
--  NPC: Vaquelage
-- Type: Item Deliverer NPC
-- !pos 17.396 1.699 -29.357 230
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
