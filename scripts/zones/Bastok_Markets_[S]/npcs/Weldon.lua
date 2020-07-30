----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Weldon
-- Type: Item Deliverer
-- !pos -191.575    -8    36.688 87
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.WELDON_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
