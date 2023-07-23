-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Houilloume
-- !pos 17.19 1.4 -29 80
-- Allegiance Change NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(103)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
