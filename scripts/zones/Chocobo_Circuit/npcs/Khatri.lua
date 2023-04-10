-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Khatri
-- !pos -322.411 0.000 -484.819 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(339)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
