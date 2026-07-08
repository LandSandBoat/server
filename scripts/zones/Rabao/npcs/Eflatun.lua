-----------------------------------
-- Area: Rabao
--  NPC: Eflatun
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -27.722, y = 2.087, z = -40.146, wait = 5000 },
    { x = -31.931, y = 0.772, z = -40.160, wait = 5000 },
    { x = -32.677, y = 0.623, z = -43.978, wait = 5000 },
    { x = -36.593, y = 0.000, z = -46.357, wait = 5000 },
    { x = -30.784, y = 0.714, z = -50.402, wait = 5000 },
    { x = -24.458, y = 3.035, z = -45.556, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
