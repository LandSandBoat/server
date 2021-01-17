-----------------------------------
-- Area: Port Jeuno
--   NPC: Dohhel
-- Type: Event Scene Replayer
-- !pos -156.031 -2 6.051 246
-----------------------------------
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10028)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
