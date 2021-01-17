-----------------------------------
-- Area: Windurst Walls
--   NPC: Orudoba-Sondeba
-- Type: Standard NPC
-- !pos 70.086 -3.503 -69.939 239
-----------------------------------
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(43)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
