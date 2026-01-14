-----------------------------------
-- Area: Lower Jeuno
--  NPC: Caged rarabs in Muckvik's Junk Shop
-----------------------------------
---@type TNpcEntity
local entity = {}

local rotationTime = 3000 -- approximate

local function rotate(npc)
    npc:setRotation(math.random(0, 255)) -- This can pick the same rotation multiple times in a row

    -- Recursive
    -- No randomness here. Both rarabs rotate at the same time.
    npc:timer(rotationTime, function(npcArg)
        rotate(npcArg)
    end)
end

entity.onSpawn = function(npc)
    rotate(npc)
end

return entity
