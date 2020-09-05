-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Prerivon
-- Type: Standard Dialogue NPC
-- !pos 142.324 0.000 132.515 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.PRERIVON_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
