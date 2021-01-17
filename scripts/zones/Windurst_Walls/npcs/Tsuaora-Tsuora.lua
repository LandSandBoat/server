-----------------------------------
-- Area: Windurst Walls
--   NPC: Tsuaora-Tsuora
-- Type: Standard NPC
-- !pos 71.489 -3.418 -67.809 239
-----------------------------------
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(42)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
