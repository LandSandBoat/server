-----------------------------------
-- Area: Port Windurst
--   NPC: Tohopka
-- Type: Standard NPC
-- !pos -105.723 -10 83.813 240
-----------------------------------
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(358)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
