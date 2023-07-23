-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Particle Gate
-- !pos -39 0 -319 34
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(172)
    return 1
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
