-----------------------------------
-- Area: Metalworks
-- Door: _6le (Presidential Suite)
-- !pos 113 -20 8 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.ITS_LOCKED)
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
