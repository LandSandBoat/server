-----------------------------------
-- Area: Windurst Waters
--  NPC: Npopo
-- !pos -35.464 -5.999 239.120 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(269)
end

return entity
