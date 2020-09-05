-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Fittesegat
-- Type: Standard Dialogue NPC
-- !pos 144.250 0.000 138.203 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.FITTESEGAT_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
