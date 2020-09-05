-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Lutete
-- Type: Standard NPC
-- !pos 169.205 -0.879 -9.107 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.LUTETE_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
