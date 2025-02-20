-----------------------------------
-- Area: Windurst Waters
--  NPC: Janta-Jonta
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -97.897, y = -2.000, z = 43.691 },
    { x = -98.851, z = 43.300 },
    { x = -103.309, z = 42.171 },
    { x = -105.608, z = 42.139 },
    { x = -109.440, z = 42.243 },
    { x = -110.261, z = 43.213 },
    { x = -110.604, z = 43.858 },
    { x = -112.127, z = 47.675 },
    { x = -111.858, z = 48.171 },
    { x = -111.007, z = 48.939 },
    { x = -106.684, z = 51.447 },
    { x = -105.403, z = 51.626 },
    { x = -104.531, z = 51.710 },
    { x = -101.276, z = 51.809 },
    { x = -100.479, z = 51.425 },
    { x = -99.801, z = 51.024 },
    { x = -99.194, z = 50.611 },
    { x = -98.361, z = 50.016 },
    { x = -94.997, z = 47.632 },
    { x = -94.958, z = 47.311 },
    { x = -95.388, z = 46.363 },
    { x = -95.963, z = 45.354 },
    { x = -97.419, z = 43.907 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
end

return entity
