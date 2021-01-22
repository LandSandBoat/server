-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Piscariaux
-- !pos -161 -2 61 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(42)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
