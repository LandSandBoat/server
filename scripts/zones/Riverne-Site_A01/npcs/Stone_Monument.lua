-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Stone Monument
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.MONUMENT)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
