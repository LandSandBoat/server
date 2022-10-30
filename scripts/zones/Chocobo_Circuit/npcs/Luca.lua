-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Luca
-- !pos -317.406 0.000 -485.091 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(338)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
