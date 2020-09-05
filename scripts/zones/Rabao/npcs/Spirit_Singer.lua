----------------------------------
-- Area: Rabao
--  NPC: Spirit Singer
-- Type: Item Deliverer
-- !pos 140.337 7.999 80.661 247
--
-----------------------------------
local ID = require("scripts/zones/Rabao/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.SPIRIT_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
