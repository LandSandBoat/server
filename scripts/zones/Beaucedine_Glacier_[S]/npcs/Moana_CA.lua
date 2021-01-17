-----------------------------------
-- Area: Beaucedine Glacier (S)
--   NPC: Moana, C.A.
-- Type: Campaign Arbiter
-- !pos -27.237 -60.888 -48.111 136
-----------------------------------
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(453)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
