----------------------------------
-- Area: Norg
--  NPC: Paleille
-- Type: Item Deliverer
-- !pos -82.667 -5.414 52.421 252
--
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.PALEILLE_DELIVERY_DIALOG)
    player:openSendBox()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
