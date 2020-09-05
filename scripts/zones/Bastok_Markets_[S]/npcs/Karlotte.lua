----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Karlotte
-- Type: Item Deliverer
-- !pos -191.646 -8 -36.349 87
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.KARLOTTE_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
