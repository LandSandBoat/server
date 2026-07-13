-----------------------------------
-- Area: Windurst Walls
--  NPC: Moan-Maon
-- !pos 88.244 -6.32 148.912 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(307)
end

return entity
