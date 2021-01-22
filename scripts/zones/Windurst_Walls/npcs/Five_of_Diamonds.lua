-----------------------------------
-- Area: Windurst Walls
--   NPC: Five of Diamonds
-- Type: Standard NPC
-- !pos -220.954 -0.001 -122.708 239
-----------------------------------
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(266)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
