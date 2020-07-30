-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Aivedoir
-- Type: Standard Dialogue NPC
-- !pos -123.119 7.999 134.490 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.AIVEDOIR_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
