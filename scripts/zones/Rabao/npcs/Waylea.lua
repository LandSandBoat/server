-----------------------------------
-- Area: Rabao
--  NPC: Waylea
-- Type: Reputation
-- !pos 12.384 4.658 -32.392 247
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    player:startEvent(57 + (player:getFameLevel(4) - 1))
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
