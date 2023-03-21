-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Linus
-- !pos -270.544 -4.000 -508.954 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(267, 271, 275, 279, 280, 281, 282, 283)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
