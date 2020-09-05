-----------------------------------
-- Area: East Ronfaure
--  NPC: Croteillard
-- Type: Gate Guard
-- !pos 87.426 -62.999 266.709 101
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.CROTEILLARD_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
