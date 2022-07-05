-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Magali
-- Standard Info NPC
-- pos -329.3409 0.0000 -296.6740
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(350)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
