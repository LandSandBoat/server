-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Cofisephe
-- Type: Adventurer's Assistant
-- !pos 210.327 -3.885 -532.511 2
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(31, 618, 652, 50, 300)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
