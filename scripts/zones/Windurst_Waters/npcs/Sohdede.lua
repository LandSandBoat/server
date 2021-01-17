-----------------------------------
-- Area: Windurst Waters
--   NPC: Sohdede
-- Type: Standard NPC
-- !pos -60.601 -7.499 111.639 238
-----------------------------------
-- Auto-Script: Requires Verification (Verfied By Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(374)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
