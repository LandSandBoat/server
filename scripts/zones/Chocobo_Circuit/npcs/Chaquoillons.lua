-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Chaquoillons
-- Standard Info NPC
-- pos -270.8263 -4.0000 -466.7501
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(238)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
