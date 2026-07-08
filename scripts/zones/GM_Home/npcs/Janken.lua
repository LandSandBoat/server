-----------------------------------
-- Area: GM Home
--  NPC: Janken
-- Plays "Rock, Paper, Scissors"
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(139)
end

return entity
