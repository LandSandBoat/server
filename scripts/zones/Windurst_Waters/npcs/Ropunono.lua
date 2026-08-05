-----------------------------------
-- Area: Windurst Waters
--  NPC: Ropunono
-- !pos -51.624 -11.249 117.476 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Ambient Optistery flavor.
    player:startEvent(283)
end

return entity
