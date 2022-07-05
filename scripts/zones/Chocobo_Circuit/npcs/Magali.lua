-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Magali
-- Standard Info NPC
-- pos 
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