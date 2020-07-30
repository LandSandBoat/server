-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Emilia
-- Type: Standard Dialogue NPC
-- !pos -39.840 -2.000 -5.403 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.EMILIA_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
