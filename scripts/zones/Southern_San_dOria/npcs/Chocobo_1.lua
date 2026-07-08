-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-- Chocobo
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 16.998, y = 2.200, z = -88.134, wait = 2000 },
    { x = 18.566, z = -91.972, wait = 5000 },
    { x = 11.348, z = -87.631, wait = 5000 },
    { x = 16.998, z = -88.134, wait = 2000 },
    { x = 12.863, z = -92.485, wait = 5000 },
    { x = 18.566, z = -91.972, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
