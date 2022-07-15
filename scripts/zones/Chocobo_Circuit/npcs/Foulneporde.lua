-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Foulneporde
-- Standard Info NPC
-- pos -253.2932 -5.0000 -470.7203
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(263)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
