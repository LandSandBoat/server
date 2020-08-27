----------------------------------
-- Area: Norg
--  NPC: Spasija
-- Type: Item Deliverer
-- !pos -82.896 -5.414 55.271 252
--
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.SPASIJA_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
