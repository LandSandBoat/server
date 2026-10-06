-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-----------------------------------
---@type TNpcEntity
local entity = {}

local points =
{
    { x = 13.350, y = 1.999, z = -100.356, wait = 5200 },
    { x = 17.497, y = 2.199, z = -100.083, wait = 800 },
    { x = 19.864, y = 2.199, z = -97.119, wait = 600 },
    { x = 16.836, y = 2.199, z = -96.729, wait = 500 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(points))
    npc:setLocalVar('point', 1)
    npc:pathThrough({ points[1] }, xi.path.flag.PATROL)
end

entity.onPathComplete = function(npc)
    local index = math.randomInt(1, #points)
    if index == npc:getLocalVar('point') then
        -- Picking its own point turns it to heading 0 and repeats that point's wait.
        npc:pathThrough({ { rotation = 0, wait = points[index].wait } }, xi.path.flag.PATROL)
        return
    end

    npc:setLocalVar('point', index)
    npc:pathThrough({ points[index] }, xi.path.flag.PATROL)
end

return entity
