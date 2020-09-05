-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ishwar
-- Type: Standard Dialogue NPC
-- !pos -47.103 -1.999 -19.582 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.ISHWAR_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
