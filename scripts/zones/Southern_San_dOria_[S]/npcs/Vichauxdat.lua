-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Vichauxdat
-- !pos 13 2 4 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(621)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
