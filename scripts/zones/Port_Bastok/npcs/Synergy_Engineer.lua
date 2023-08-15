-----------------------------------
-- Area: Port Bastok
--  NPC: Synergy Engineer
-- !pos 37.700 -0.3 -50.500 236
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(11002)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
