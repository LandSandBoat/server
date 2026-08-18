-----------------------------------
-- Area: Windurst Waters
--  NPC: Serukoko
-- !pos -54.916 -6.499 114.855 238
-----------------------------------
---@type TNpcEntity
local entity = {}

local function idle(npc)
    npc:entityAnimationPacket('sha0')

    npc:timer(math.randomInt(3000, 4000), function(npcArg)
        idle(npcArg)
    end)
end

entity.onSpawn = function(npc)
    idle(npc)
end

return entity
