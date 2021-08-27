-----------------------------------
-- Area: Port Jeuno
--  NPC: Guide Stone
-- !pos -149 -3 0 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    player:messageSpecial(ID.text.GUIDE_STONE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
