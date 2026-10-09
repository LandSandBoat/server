-----------------------------------
-- Area: Bastok Mines
--  NPC: Keturah
-- !pos 26.761 0.871 -89.687 234
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(546, VanadielTime(), 0, 5)
end

return entity
