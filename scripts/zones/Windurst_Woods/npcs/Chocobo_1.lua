-----------------------------------
-- Area: Windurst Woods
--  NPC: Chocobo
-----------------------------------
---@type TNpcEntity
local entity = {}

local points =
{
    { x = 124.669, y = -5.000, z = -102.273, wait = 1900 },
    { x = 128.215, y = -5.000, z = -104.243, wait = 1900 },
    { x = 121.099, y = -5.000, z = -108.742, wait = 1900 },
    { x = 124.660, y = -5.000, z = -110.186, wait = 1900 },
    { x = 124.632, y = -5.000, z = -111.154, wait = 1900 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(points))
    npc:setLocalVar('point', 1)
    npc:pathThrough({ points[1] }, xi.path.flag.PATROL)
end

entity.onPathComplete = function(npc)
    -- Runs about half the time.
    npc:setBaseSpeed(math.randomInt(1, 2) == 1 and 80 or 27)

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
