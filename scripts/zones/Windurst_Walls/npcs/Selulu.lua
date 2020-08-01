----------------------------------
-- Area: Windurst Walls
--  NPC: Selulu
-- Type: Item Deliverer
-- !pos 58.027 -2.5 -60.548 239
--
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
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
