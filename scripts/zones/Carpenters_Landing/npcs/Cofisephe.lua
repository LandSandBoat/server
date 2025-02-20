-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Cofisephe
-- Type: Adventurer's Assistant
-- !pos 210.327 -3.885 -532.511 2
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(31, 618, 652, 50, 300)
end

return entity
