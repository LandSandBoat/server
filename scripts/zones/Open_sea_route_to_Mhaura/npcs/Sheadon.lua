-----------------------------------
-- Area: Open_sea_route_to_Mhaura
--  NPC: Sheadon
-- Notes: Tells ship ETA time
-- !pos 0.340 -12.232 -4.120 47
-----------------------------------
local ID = require("scripts/zones/Open_sea_route_to_Mhaura/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.ON_WAY_TO_MHAURA, 0, 0) -- Earth Time, Vana Hours. Needs a get-time function for boat?
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
