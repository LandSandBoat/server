-----------------------------------
-- Area: Windurst Woods
--  NPC: Femardaque
-----------------------------------
---@type TNpcEntity
local entity = {}

local function lookAround(npc)
    npc:pathThrough(
    {
        { rotation = 250, wait = math.randomInt(5000, 9000) },
        { rotation = 56, wait = math.randomInt(5000, 9000) },
    }, xi.path.flag.PATROL)
end

entity.onSpawn = function(npc)
    npc:initNpcAi()
    lookAround(npc)
end

-- Re-rolls both holds on each lap.
entity.onPathComplete = function(npc)
    lookAround(npc)
end

return entity
