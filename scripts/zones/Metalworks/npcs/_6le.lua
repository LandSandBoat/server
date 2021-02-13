-----------------------------------
-- Area: Metalworks
-- Door: _6le (Presidential Suite)
-- !pos 113 -20 8 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.ITS_LOCKED)
    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
