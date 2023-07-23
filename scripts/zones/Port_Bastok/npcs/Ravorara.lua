-----------------------------------
-- Area: Port Bastok
--  NPC: Ravorara
-- Type: Quest Giver
-- !pos -151.062 -7 -7.243 236
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(310)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
