-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Taby Canatahey
-- !pos -119.119 -4.106 -524.347 116
-----------------------------------
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.TABY_CANATAHEY_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
