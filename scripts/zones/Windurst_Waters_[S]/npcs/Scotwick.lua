-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Scotwick
-- Type: Allied Notes Notorious Monsters
-- !pos 153.785 -3.134 9.895 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(16)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
