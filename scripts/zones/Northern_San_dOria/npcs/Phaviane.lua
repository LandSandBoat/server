-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Phaviane
-- Type: Standard Dialogue NPC
-- !pos -4.000 0.000 -28.000 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.PHAVIANE_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
