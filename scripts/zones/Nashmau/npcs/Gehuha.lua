-----------------------------------
-- Area: Nashmau
--  NPC: Gehuha
-- Type: Event Scene Replayer
-- !pos -13.414 -1 -50.825 53
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(13)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
