-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Prillaure
-- Type: Event Scene Replayer
-- !pos -143.000 0.999 9.000 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(503)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
