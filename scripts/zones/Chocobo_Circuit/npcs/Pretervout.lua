-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Pretervout
-- !pos -258.831 -4.000 -452.048 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(267, 268, 269, 270, 271, 275, 279, 283)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
