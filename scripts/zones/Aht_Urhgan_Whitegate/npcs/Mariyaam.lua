-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mariyaam
-- Type: Item Deliverer
-- !pos -125 -6 90 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
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
