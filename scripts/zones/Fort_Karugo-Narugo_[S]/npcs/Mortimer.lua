----------------------------------
-- Area: Fort Karugo Narugo [S]
--  NPC: Mortimer
-- Type: Item Deliverer
-- !pos -24.08 -68.508 93.88 96
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
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
