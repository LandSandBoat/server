-----------------------------------
-- Area: Al Zahbi
--  NPC: Najaaj
-- !pos 61.563 -1 36.264 48
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 40.548, y = 0.000, z = 36.430, wait = 2000 },
    { rotation = 0, wait = 2400 },
    { x = 66.700, y = 0.000, z = 36.224, wait = 2000 },
    { rotation = 120, wait = 5400 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
