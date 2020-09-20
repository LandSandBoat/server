-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Heih Porhiaap
-- !pos -118.876 -4.088 -515.731 116
-----------------------------------
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.HEIH_PORHIAAP_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
