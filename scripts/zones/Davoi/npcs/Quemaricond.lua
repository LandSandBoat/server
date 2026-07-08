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
    -- West side
    { x = -21.870, y = -0.600, z = -17.462, rotation = 191, wait = 3000 },
    { x = -21.870, y = -0.600, z = -17.462, rotation = 070, wait = 4000 },
    { x = -21.870, y = -0.600, z = -17.462, rotation = 003, wait = 3000 },
    -- Middle
    { x =  11.934, y = -0.116, z = -23.842, rotation = 246, wait = 3000 },
    { x =  11.934, y = -0.116, z = -23.842, rotation = 131, wait = 3000 },
    { x =  11.934, y = -0.116, z = -23.842, rotation = 246, wait = 3000 },
    -- Bridge
    { x =  46.920, y = -0.509, z = -20.124, rotation = 245, wait = 7000 },
    -- Middle
    { x =  11.934, y = -0.116, z = -23.842, rotation = 131, wait = 3000 },
    { x =  11.934, y = -0.116, z = -23.842, rotation = 246, wait = 3000 },
    -- Enroute back to west side used for lap counter
    { x =  -5.203, y = -0.010, z = -20.765, rotation = 136 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
    npc:setLocalVar('lap', 0)
    npc:setLocalVar('talked', 0)
end

entity.onPath = function(npc)
    local lap    = npc:getLocalVar('lap')
    local talked = npc:getLocalVar('talked')

    if npc:atPoint(xi.path.get(pathNodes, 10)) then
        lap = lap <= 2 and lap + 1 or 0
        npc:setLocalVar('lap', lap)
        npc:setLocalVar('talked', 0)
    end

    if talked == 0 then
        if lap == 0 and npc:atPoint(xi.path.get(pathNodes, 2)) then
            npc:showText(npc, ID.text.QUEMARICOND_LOST)
            npc:setLocalVar('talked', 1)
        elseif lap == 1 and npc:atPoint(xi.path.get(pathNodes, 7)) then
            npc:showText(npc, ID.text.QUEMARICOND_CAME_THIS_WAY)
            npc:setLocalVar('talked', 1)
        elseif lap == 3 and npc:atPoint(xi.path.get(pathNodes, 5)) then
            npc:showText(npc, ID.text.QUEMARICOND_OVER_THERE)
            npc:setLocalVar('talked', 1)
        end
    end
end

return entity
