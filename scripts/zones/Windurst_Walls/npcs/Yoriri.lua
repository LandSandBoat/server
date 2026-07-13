-----------------------------------
-- Area: Windurst Walls
--  NPC: Yoriri
-- !pos 65.268 -8.5 -58.309 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(313)
end

return entity
