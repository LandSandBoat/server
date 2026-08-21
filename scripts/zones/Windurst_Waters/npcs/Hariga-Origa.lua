-----------------------------------
-- Area: Windurst Waters
--  NPC: Hariga-Origa
-- !pos -62.511 -5.499 105.234 238
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
