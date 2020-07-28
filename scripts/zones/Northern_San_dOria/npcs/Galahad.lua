-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Galahad
-- Type: Consulate Representative NPC
-- !pos -51.984 -2.000 -15.373 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.GALAHAD_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
