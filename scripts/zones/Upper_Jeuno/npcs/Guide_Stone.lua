-----------------------------------
-- Area: Upper Jeuno
--  NPC: Guide Stone
-- !pos 25 -3 -41 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
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
