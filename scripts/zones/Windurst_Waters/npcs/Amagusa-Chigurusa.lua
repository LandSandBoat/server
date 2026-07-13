-----------------------------------
-- Area: Windurst Waters
--  NPC: Amagusa-Chigurusa
-- !pos -28.746 -4.5 61.954 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(562)
end

return entity
