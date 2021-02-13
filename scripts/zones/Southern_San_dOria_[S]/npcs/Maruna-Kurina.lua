-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Maruna-Karina
-- !pos 166 -7 42 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(520)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
