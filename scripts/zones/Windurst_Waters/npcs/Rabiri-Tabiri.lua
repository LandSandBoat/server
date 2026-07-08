-----------------------------------
-- Area: Windurst Waters
--  NPC: Rabiri-Tabiri
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -109.833, y = -2.000, z = 49.970, rotation = 32, wait = 6000 },
    { x = -97.530, z = 50.283, rotation = 118, wait = 6000 },
    { x = -104.014, z = 42.639, rotation = 214, wait = 6000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
end

return entity
