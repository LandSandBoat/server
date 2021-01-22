-----------------------------------
-- Area: Metalworks
--   NPC: Riault
-- Type: Standard NPC
-- !pos 26.988 -17.39 -41.931 237
-----------------------------------
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(201)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
