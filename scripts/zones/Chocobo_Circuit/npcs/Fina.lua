-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Fina
-- !pos -377.999 0.004 -533.550 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(341)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
