-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Daigraffeaux
-- !pos -7 2 -89 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(620)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
