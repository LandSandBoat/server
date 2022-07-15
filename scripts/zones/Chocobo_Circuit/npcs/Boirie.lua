-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Boirie
-- Standard Info NPC
-- pos -387.4615 -5.0000 -490.9008
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(266)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
