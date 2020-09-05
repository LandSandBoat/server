-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pellimie
-- Type: Standard Dialogue NPC
-- !pos 145.459 0.000 131.540 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.PELLIMIE_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
