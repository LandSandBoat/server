-----------------------------------
-- Area: Castle Oztroja
--  NPC: Tebhi
-- !pos -136 24 -21 151
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -136.0000, y = 24.2500, z = -21.0000 },
    { x = -140.0788, y = 24.2500, z = -25.9524 },
    { x = -140.1171, y = 24.2500, z = -37.6438 },
    { x = -140.1195, y = 24.2500, z = -45.9640 },
    { x = -140.1225, y = 24.2500, z = -55.6002 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

return entity
