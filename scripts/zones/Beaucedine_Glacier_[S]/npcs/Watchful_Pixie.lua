-----------------------------------
-- Area: Beaucedine Glacier (S)
--  NPC: Watchful Pixie
-- !pos -56.000 -1.3 -392.000 136
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO: Conflict with default action
    player:startEvent(4002)
end

return entity
