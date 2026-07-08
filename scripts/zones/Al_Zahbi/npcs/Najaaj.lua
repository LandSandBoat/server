-----------------------------------
-- Area: Al Zahbi
--  NPC: Najaaj
-- !pos 61.563 -1 36.264 48
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 40.000, y = 0.000, z = 36.000, wait = 2000 },
    { rotation = 0, wait = 3000 },
    { x = 67.000, wait = 2000 },
    { rotation = 128, wait = 3000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
