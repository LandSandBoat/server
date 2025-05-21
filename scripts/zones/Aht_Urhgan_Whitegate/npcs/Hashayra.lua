-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Hashayra
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 96.832, y = -6.000, z = -110.566, wait = 1000 },
    { rotation = 146, wait = 1000 },
    { x = 86.308, y = -6.000, z = -105.927, wait = 100 },
    { rotation = 14, wait = 1000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
