-----------------------------------
-- Area: Lower Jeuno
--  NPC: Guide Stone
-- !pos  19 -3 47 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
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
