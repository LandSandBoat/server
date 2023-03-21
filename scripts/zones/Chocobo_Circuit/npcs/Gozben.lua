-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Gozben
-- !pos -270.387 -4.000 -451.198 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(267, 271, 275, 276, 277, 278, 279, 283)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
