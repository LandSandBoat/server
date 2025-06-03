-----------------------------------
-- Area: Windurst Walls
--  NPC: Karija-Marija
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Karija-Marija doesn't stop walking, so all the points
-- below are based on the last position of his current
-- rotation as he doesnt walk in a straight line.
-- TODO: npc doesnt need to stop at point to change direction
local pathNodes =
{
    { x = 82.146, y = -2.500, z = -113.624 },
    { x = 81.814, z = -101.618 },
    { x = 81.406, z = -100.469 },
    { x = 80.962, z = -99.366 },
    { x = 80.465, z = -98.145 },
    { x = 78.268, z = -92.760 },
    { x = 76.941, z = -90.049 },
    { x = 75.845, z = -88.848 },
    { x = 64.879, y = -2.458, z = -76.964 },
    { x = 64.062, y = -2.425, z = -76.346 },
    { x = 62.665, y = -2.367, z = -75.797 },
    { x = 58.706, y = -2.352, z = -74.414 },
    { x = 62.665, y = -2.367, z = -75.797 },
    { x = 64.062, y = -2.425, z = -76.346 },
    { x = 64.879, y = -2.458, z = -76.964 },
    { x = 75.845, y = -2.500, z = -88.848 },
    { x = 76.941, z = -90.049 },
    { x = 78.268, z = -92.760 },
    { x = 80.465, z = -98.145 },
    { x = 80.962, z = -99.366 },
    { x = 81.406, z = -100.469 },
    { x = 81.814, z = -101.618 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
