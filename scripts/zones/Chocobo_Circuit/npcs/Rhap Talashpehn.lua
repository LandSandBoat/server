-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Rhap Talashpehn
-- !pos -375.043 -4.000 -508.225 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(287, 291, 295, 300, 304, 305, 306, 307)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
