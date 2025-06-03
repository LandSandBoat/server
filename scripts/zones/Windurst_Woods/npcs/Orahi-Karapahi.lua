-----------------------------------
-- Area: Windurst Woods
--  NPC: Orahi-Karapahi
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 63.612, y = -4.250, z = 102.695, wait = 4000 },
    { x = 60.000, y = -4.250, z = 103.188 },
    { x = 58.772, y = -4.250, z = 103.357, wait = 4000 },
    { x = 60.000, y = -4.250, z = 103.188 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
