-----------------------------------
-- Area: Port Windurst
--  NPC: Laughing Lizard
-- !pos -193.673 -2 77.673 240
-----------------------------------
---@type TNpcEntity
local entity = {}

local fishingLoop =
{
    { xi.animation.FISHING,         15000 },
    { xi.animation.FISHING_FIGHT_1,  5000 },
    { xi.animation.FISHING_FIGHT_3,  5000 },
    { xi.animation.FISHING_FIGHT_2,  5000 },
    { xi.animation.FISHING_FIGHT_1,  5000 },
    { xi.animation.FISHING_FIGHT_3,  5000 },
    { xi.animation.FISHING_FIGHT_2,  5000 },
    { xi.animation.FISHING_FIGHT_1,  5000 },
    { xi.animation.FISHING_STOP,     6000 },
    { xi.animation.NONE,             5000 },
}

local function playStep(npc, step)
    npc:setAnimation(fishingLoop[step][1])
    npc:timer(fishingLoop[step][2], function(npcArg)
        playStep(npcArg, step % #fishingLoop + 1)
    end)
end

entity.onSpawn = function(npc)
    playStep(npc, 1)
end

return entity
