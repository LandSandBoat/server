-----------------------------------
-- Area: Windurst Walls
--  NPC: Naih Arihmepp
-- !pos -64.578 -13.465 202.147 239
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -63.660, y = -12.500, z = 204.874, wait = 5000 },
    { rotation = 68, wait = 1000 },
    { x = -67.755, y = -12.348, z = 192.724, wait = 5000 },
    { rotation = 196, wait = 1000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrigger = function(player, npc)
    player:startEvent(326)
end

return entity
