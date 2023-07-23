-----------------------------------
-- Area: Jugner Forest (S)
--  NPC: Larkin, C.A.
-- Type: Campaign Arbiter
-- !pos 50.217 -1.769 51.095 82
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(453)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
