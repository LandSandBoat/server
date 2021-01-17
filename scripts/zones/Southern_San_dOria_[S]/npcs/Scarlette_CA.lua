-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Scarlette C.A
-- !pos -27 2 -29 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(459)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
