-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-----------------------------------
---@type TNpcEntity
local entity = {}

local points =
{
    { x = 24.243, y = 1.999, z = -92.376, wait = 2000 },
    { x = 25.019, y = 1.999, z = -90.039, wait = 1800 },
    { x = 27.573, y = 1.999, z = -90.529, wait = 1500 },
    { x = 26.665, y = 1.999, z = -92.299, wait = 1200 },
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
