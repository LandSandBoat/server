-----------------------------------
-- Area: Beaucedine Glacier (S)
--  NPC: Moana, C.A.
-- Type: Campaign Arbiter
-- !pos -27.237 -60.888 -48.111 136
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(453)
end

return entity
