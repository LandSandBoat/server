-----------------------------------
-- Area: Rabao
--  NPC: Waylea
-- Type: Reputation
-- !pos 12.384 4.658 -32.392 247
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(57 + (player:getFameLevel(4) - 1))
end

return entity
