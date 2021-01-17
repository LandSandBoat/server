-----------------------------------
-- Area: Port Jeuno
--   NPC: Rachocho
-- Type: Standard NPC
-- !pos 3.789 7 -59.411 246
-----------------------------------
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(47)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
