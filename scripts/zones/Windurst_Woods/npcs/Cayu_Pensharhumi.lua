-----------------------------------
-- Area: Windurst Woods
--  NPC: Cayu Pensharhumi
-- !pos 39.437 -0.91 -40.808 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(259)
end

return entity
