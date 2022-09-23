-----------------------------------
-- Area: Bastok Markets
--  NPC: Marin
-- Type: Quest Giver
-- !pos -340.060 -11.003 -148.181 235
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(361)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
