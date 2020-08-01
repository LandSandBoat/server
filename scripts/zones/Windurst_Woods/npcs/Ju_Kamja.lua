----------------------------------
-- Area: Windurst Woods
--  NPC: Ju Kamja
-- Type: Item Deliverer
-- !pos 58.145 -2.5 -136.91 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
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
