-----------------------------------
-- Area: Windurst Waters
--  NPC: Mejina-Monjina
-- !pos -61.924 -11.249 108.022 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Ambient stargazing flavor.
    player:startEvent(282)
end

return entity
