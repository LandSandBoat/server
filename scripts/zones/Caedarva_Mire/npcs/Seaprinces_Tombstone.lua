-----------------------------------
-- Area: Caedarva Mire
--  NPC: Seaprince's Tombstone
-- Involved in quest: Forging a New Myth
-- !pos  -433 7 -586 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    player:messageSpecial(ID.text.SEAPRINCES_TOMBSTONE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
