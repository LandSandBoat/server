-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Karsten
-- Standard Info NPC
-- pos -340.8314 -0.0110 -299.6195
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(345)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
