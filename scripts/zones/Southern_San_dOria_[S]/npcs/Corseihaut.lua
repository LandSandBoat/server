-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Corseihaut
-- !pos -122 -6 93 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(610)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
