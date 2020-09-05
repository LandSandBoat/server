-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Nembet
-- !pos 147 -3 110 80
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
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
