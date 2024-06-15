-----------------------------------
-- Area: Misareaux Coast
--  NPC: Dilapidated Gate
-- Note: Entrance to Misareaux Coast
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(553)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
