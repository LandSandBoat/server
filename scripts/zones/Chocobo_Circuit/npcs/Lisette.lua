-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Lisette
-- Standard Info NPC
-- pos 
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(348)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
