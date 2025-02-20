-----------------------------------
-- Area: Lower Jeuno
--  NPC: Nakho_Jawantal
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -66.994, y = -6.000, z = -133.674, wait = 3000 },
    { x = -65.683, z = -130.305, wait = 3000 },
    { x = -65.975, z = -133.626, wait = 3000 },
    { x = -66.994, z = -133.674, wait = 3000 },
    { x = -63.785, z = -134.118, wait = 3000 },
    { x = -65.683, z = -130.305, wait = 3000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
