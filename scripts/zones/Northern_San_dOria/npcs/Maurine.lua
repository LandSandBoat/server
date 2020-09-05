-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Maurine
-- Type: Standard Dialogue NPC
-- !pos 144.852 0.000 136.828 231
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.MAURINE_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
