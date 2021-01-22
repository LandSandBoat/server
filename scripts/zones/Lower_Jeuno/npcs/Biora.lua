-----------------------------------
-- Area: Lower Jeuno
--   NPC: Biora
-- Type: Map Viewer
-- !pos -28.768 -2 -11.300 245
-----------------------------------
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(205)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
