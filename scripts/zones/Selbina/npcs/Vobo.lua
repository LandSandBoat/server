-----------------------------------
-- Area: Selbina
--  NPC: Vobo
-- Involved in Quest: Riding on the Clouds
-- !pos 37 -14 81 248
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(710)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
