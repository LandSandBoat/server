-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Adrian
-- Standard Info NPC
-- POS: -330.5837 0.0000 -468.5058
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
