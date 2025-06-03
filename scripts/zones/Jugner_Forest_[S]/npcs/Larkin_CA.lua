-----------------------------------
-- Area: Jugner Forest (S)
--  NPC: Larkin, C.A.
-- Type: Campaign Arbiter
-- !pos 50.217 -1.769 51.095 82
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(453)
end

return entity
