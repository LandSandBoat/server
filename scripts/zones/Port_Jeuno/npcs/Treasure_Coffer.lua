-----------------------------------
-- Area: Port Jeuno
--  NPC: Treasure Coffer
-- !pos  -52 0 -11 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    player:messageSpecial(ID.text.CHEST_IS_EMPTY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
