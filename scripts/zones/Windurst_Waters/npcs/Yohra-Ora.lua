-----------------------------------
-- Area: Windurst Waters
--  NPC: Yohra-Ora
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -44.506, y = -5.000, z = 74.003, wait = 5000 },
    { x = -32.241, y = -5.000, z = 74.480, wait = 5000 },
    { x = -39.187, y = -5.000, z = 78.766, wait = 5000 },
    { x = -44.506, y = -5.000, z = 74.003, wait = 5000 },
    { x = -39.187, y = -5.000, z = 78.766, wait = 5000 },
    { x = -32.241, y = -5.000, z = 74.480, wait = 5000 },
    { x = -39.187, y = -5.000, z = 78.766, wait = 5000 },
    { x = -32.241, y = -5.000, z = 74.480, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
