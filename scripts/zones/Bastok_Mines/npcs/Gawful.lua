-----------------------------------
-- Area: Bastok Mines
--  NPC: Gawful
-- Type: Item Deliverer
-- !pos -22.416 -3.999 -56.076 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
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
