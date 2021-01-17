-----------------------------------
-- Area: Port Windurst
--   NPC: Ada
-- Type: Standard NPC
-- !pos -79.803 -6.75 168.652 240
-----------------------------------
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(44)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
