-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Leis
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{

    { x = -8.826, y = 1.996, z = 132.537, rotation = 64, wait = 8000 },
    { x = -8.294, y = 1.996, z = 137.101, rotation = 0, wait = 8000 },
    { x = -8.826, y = 1.996, z = 132.537, rotation = 64, wait = 8000 },
    { x = -12.483, y = 1.984, z = 136.894, rotation = 128, wait = 8000 },
    { x = -8.294, y = 1.996, z = 137.101, rotation = 0, wait = 8000 },
    { x = -12.483, y = 1.984, z = 136.894, rotation = 128, wait = 8000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
