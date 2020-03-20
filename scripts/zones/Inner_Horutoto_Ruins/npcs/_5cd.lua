-----------------------------------
-- Area: Inner Horutoto Ruins
--  NPC: _5cd (Gate of Water)
-- !pos -228 0 140 192
-----------------------------------
local ID = require("scripts/zones/Inner_Horutoto_Ruins/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.DOOR_FIRMLY_CLOSED)
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
