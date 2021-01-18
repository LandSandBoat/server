-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Quartermaster
-- !pos -22 2 -3 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(201)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
