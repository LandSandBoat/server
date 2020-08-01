-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Yassi-Possi
-- Type: Item Deliverer
-- !pos 153.992 -0.001 -18.687 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.YASSI_POSSI_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
