-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Archanne
-- Type: Event Scene Replayer
-- !pos -54.104 10.999 -34.144 243
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10007)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
