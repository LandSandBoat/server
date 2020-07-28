-----------------------------------
-- Area: Caedarva Mire
--  NPC: qm5
-- Involved in quest: Get the Picture
-- !pos  -389 6 -597 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
