-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Mercedes
-- Race Attendant (Blue)
-- pos -362.8061 4.0000 -530.8210
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(343)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
