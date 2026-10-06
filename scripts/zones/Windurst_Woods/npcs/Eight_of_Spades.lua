-----------------------------------
-- Area: Windurst Woods
--  NPC: Eight of Spades
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Walks the short leg twice before each trip to the far end.
local pathNodes =
{
    { x = 91.610, y = -4.567, z = -74.808 },
    { x = 96.853, y = -4.866, z = -79.802 },
    { x = 91.610, y = -4.567, z = -74.808 },
    { x = 96.853, y = -4.866, z = -79.802 },
    { x = 89.833, y = -4.815, z = -61.884 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
