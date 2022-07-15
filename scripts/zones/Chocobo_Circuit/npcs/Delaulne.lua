-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Delaulne
-- Race Attendant (Orange)
-- pos -392.9876 4.0000 -531.7893
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(340)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
