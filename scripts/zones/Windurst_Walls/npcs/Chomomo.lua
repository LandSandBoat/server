-----------------------------------
-- Area: Windurst Walls
--  NPC: Chomomo
-- !pos -1.262 -11 290.224 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(325)
end

return entity
