-----------------------------------
-- Area: Chateau d'Oraguille
--   NPC: Chaloutte
-- Type: Event Scene Replayer
-- !pos 10.450 -1 -11.985 233
-----------------------------------
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(557)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
