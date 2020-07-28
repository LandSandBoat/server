----------------------------------
-- Area: Windurst Woods
--  NPC: Pew Sahbaraef
-- Type: Item Deliverer
-- !pos 61.899 -2.5 -112.956 241
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
