-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Malfine
-- Type: Standard Dialogue NPC
-- !pos 136.943 0.000 132.305 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.MALFINE_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
