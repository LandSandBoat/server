-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Aurfet
-- !pos -78 -8 -22 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(127)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
