-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Tombstone
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
player:messageSpecial(ID.text.TOMBSTONE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
