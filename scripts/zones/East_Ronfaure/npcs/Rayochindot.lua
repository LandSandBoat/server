-----------------------------------
-- Area: East Ronfaure
--  NPC: Rayochindot
-- Type: Gate Guard
-- !pos 93.159 -62.999 272.601 101
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.RAYOCHINDOT_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
