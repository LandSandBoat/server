-----------------------------------
-- Area: Port Bastok
--  NPC: Mustafa
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.MUSTAFA_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
