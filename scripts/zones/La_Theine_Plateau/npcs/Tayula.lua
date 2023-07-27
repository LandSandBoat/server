-----------------------------------
-- Area: La Theine Plateau
--  NPC: Tayula
-- Type: Mission
-- !pos -311.785 50.351 182.063 102
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(105)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
