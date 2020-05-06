-----------------------------------
-- Area: Lower Delkfutt's Tower
--  NPC: Cermet Door
-----------------------------------
local ID = require("scripts/zones/Lower_Delkfutts_Tower/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.DOOR_FIRMLY_SHUT)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
