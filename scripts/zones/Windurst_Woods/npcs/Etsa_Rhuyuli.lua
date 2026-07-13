-----------------------------------
-- Area: Windurst Woods
--  NPC: Etsa Rhuyuli
-- !pos 62.482 -8.499 -139.836 241
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 62.150, y = -7.500, z = -138.060 },
    { x = 62.843, z = -141.761 },
    { x = 63.382, z = -144.635 },
    { x = 62.843, z = -141.761 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrigger = function(player, npc)
    player:startEvent(422)
end

return entity
