-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-----------------------------------
---@type TNpcEntity
local entity = {}

local points =
{
    { x = 11.348, y = 2.201, z = -87.631, wait = 2900 },
    { x = 16.998, y = 2.201, z = -88.134, wait = 3200 },
    { x = 18.566, y = 2.201, z = -91.972, wait = 3400 },
    { x = 12.863, y = 2.201, z = -92.485, wait = 2000 },
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
