-----------------------------------
-- Area: Beaucedine Glacier (S)
--  NPC: Luhk Leotih, M.C.
-- Type: Campaign Arbiter
-- !pos 76.178 -60.763 -48.775 136
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(452)
end

return entity
