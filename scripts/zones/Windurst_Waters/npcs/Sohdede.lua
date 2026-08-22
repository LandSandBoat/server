-----------------------------------
-- Area: Windurst Waters
--  NPC: Sohdede
-- !pos -60.601 -6.499 111.639 238
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
