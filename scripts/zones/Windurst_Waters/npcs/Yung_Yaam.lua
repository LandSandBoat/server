-----------------------------------
-- Area: Windurst Waters
--  NPC: Yung Yaam
-- !pos -66 -4 27 238
-----------------------------------
---@type TNpcEntity
local entity = {}

-- She waits tables along the north wall, working her way down the row and then
-- walking straight back to the far end to start again. At each table she turns to
-- face it and stands there for about nine seconds before moving on.
local pathNodes =
{
    { x = -65.622, y = -3.800, z = 27.019, wait = 100 },
    { rotation = 142, wait = 9000 },
    { x = -60.774, y = -3.500, z = 25.870, wait = 100 },
    { rotation = 236, wait = 9000 },
    { x = -57.604, y = -3.500, z = 24.064, wait = 100 },
    { rotation = 226, wait = 9000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
