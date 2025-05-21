-----------------------------------
-- Area: Davoi
--  NPC: Quemaricond
-- Involved in Mission: Infiltrate Davoi
-- !pos 23 0.1 -23 149
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 20.6, y = 0.0, z = -23.0 },
    { x = 46.0, y = 0.0, z = -19.0 },
    { x = 53.5, y = -1.8, z = -19.0 },
    { x = 61.0, y = -1.1, z = -18.6 },
    { x = 67.3, y = -1.5, z = -18.6 },
    { x = 90.0, y = -0.5, z = -19.0 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.QUEMARICOND_DIALOG)
    npc:clearPath(true)
    npc:wait(2000)
    npc:continuePath()
end

return entity
