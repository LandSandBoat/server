-----------------------------------
-- Area: Rabao
--  NPC: Yabehbeh
-- !pos 19.299, 6.624, -13.748
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 19.299, y = 6.624, z = -13.748, wait = 8000 },
    { x = 20.759, y = 6.486, z = -14.418, wait = 2000 },
    { x = 26.436, y = 6.633, z = -10.816, wait = 5000 },
    { x = 30.162, y = 8.000, z = -3.1530, wait = 5000 },
    { x = 23.912, y = 8.000, z = -0.229, wait = 5000 },
    { x = 12.840, y = 8.111, z = -6.472, wait = 5000 },
    { x = 10.804, y = 7.753, z = -14.958, wait = 5000 },
    { x = 16.258, y = 6.775, z = -15.863, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
