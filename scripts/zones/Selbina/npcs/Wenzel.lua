----------------------------------
-- Area: Selbina
--  NPC: Wenzel
-- Type: Item Deliverer
-- !pos 31.961 -14.661 57.997 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.WENZEL_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
