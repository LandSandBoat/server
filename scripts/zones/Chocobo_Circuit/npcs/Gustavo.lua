-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Gustavo
-- Standard Info NPC
-- pos
-- event 226
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(226)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
