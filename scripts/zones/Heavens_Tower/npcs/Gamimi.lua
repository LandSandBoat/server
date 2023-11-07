-----------------------------------
-- Area: Heavens Tower
--  NPC: Gamimi
-- Type: GOLD WORLD PASS ARBITER
-- !pos 4 0.1 32 242
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Currently selecting option 1 will result in a hard lock of the player requiring them to force quit the client.
    -- This likely needs special handling in the core.
    -- player:startEvent(10000) -- , 0, 0, 0, 0, 0, -1, 2)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
