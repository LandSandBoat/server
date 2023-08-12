-----------------------------------
-- Area: North Gustaberg
--  NPC: Hunting Bear
--  Involved in Quest "The Gustaberg Tour"
-- !pos -232.415 40.465 426.495 106
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(20)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
