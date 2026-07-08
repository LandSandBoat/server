-----------------------------------
-- Area: Jugner Forest (S)
--  NPC: Roiloux, R.K.
-- Type: Campaign Arbiter
-- !pos 70.493 -0.602 -9.185 82
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(450)
end

return entity
