-----------------------------------
-- Area: Beaucedine Glacier (S)
--  NPC: Gray Colossus, L.C.
-- Type: Campaign Arbiter
-- !pos 76.178 -60.763 -48.775 136
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(451)
end

return entity
