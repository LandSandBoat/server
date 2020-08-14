-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arienh
-- Type: Standard Dialogue NPC
-- !pos -37.292 -2.000 -6.817 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.ARIENH_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
