----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Suzel
-- Type: Item Deliverer
-- !pos -72.701 -20.25 -64.058 26
--
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
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
