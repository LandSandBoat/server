-----------------------------------
-- Area: Behemoth's Dominion
--  HNM: Behemoth
-----------------------------------
local ID = zones[xi.zone.BEHEMOTHS_DOMINION]
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Spawn points are for era hnm spawns
entity.spawnPoints =
{
    { x = -277.763, y = -20.309, z =  72.189 },
    { x = -236.097, y = -19.030, z =  20.582 },
    { x = -239.829, y = -19.017, z =  60.325 },
    { x = -245.463, y = -19.864, z =  49.767 },
    { x = -243.601, y = -19.067, z =  18.680 },
    { x = -271.155, y = -19.248, z =  59.935 },
    { x = -268.381, y = -20.327, z =  23.361 },
    { x = -220.682, y = -19.537, z =  29.991 },
    { x = -202.783, y = -19.254, z =  64.501 },
    { x = -268.644, y = -19.752, z =  65.473 },
    { x = -233.803, y = -19.665, z =  29.285 },
    { x = -224.944, y = -19.403, z =  73.941 },
    { x = -205.924, y = -19.107, z =  59.944 },
    { x = -255.954, y = -19.209, z =  39.293 },
    { x = -241.015, y = -19.758, z =  48.865 },
    { x = -275.621, y = -19.982, z =  40.647 },
    { x = -277.167, y = -20.010, z =  76.177 },
    { x = -244.339, y = -19.684, z =  29.301 },
    { x = -247.063, y = -19.931, z =  51.601 },
    { x = -275.421, y = -19.387, z =  65.208 },
    { x = -229.189, y = -20.039, z =  71.014 },
    { x = -238.301, y = -19.638, z =  68.747 },
    { x = -248.994, y = -19.672, z =  26.165 },
    { x = -232.554, y = -19.814, z =  16.558 },
    { x = -209.320, y = -20.016, z =  48.118 },
    { x = -237.104, y = -19.007, z =  60.122 },
    { x = -264.964, y = -19.624, z =  72.804 },
    { x = -238.056, y = -19.742, z =  70.810 },
    { x = -234.731, y = -19.389, z =  26.156 },
    { x = -263.275, y = -19.237, z =  75.329 },
    { x = -249.483, y = -20.000, z =  70.077 },
    { x = -263.325, y = -19.835, z =  61.364 },
    { x = -244.573, y = -19.130, z =  18.021 },
    { x = -242.115, y = -19.360, z =  14.437 },
    { x = -260.186, y = -19.330, z =  10.312 },
    { x = -272.583, y = -19.833, z =  29.200 },
    { x = -203.146, y = -19.669, z =  50.643 },
    { x = -258.461, y = -19.078, z =  36.431 },
    { x = -201.804, y = -19.634, z =  68.656 },
    { x = -207.906, y = -19.889, z =  45.647 },
    { x = -243.488, y = -19.030, z =  20.576 },
    { x = -257.096, y = -19.792, z =  11.574 },
    { x = -245.934, y = -19.260, z =  15.478 },
    { x = -253.225, y = -19.882, z =  52.921 },
    { x = -274.141, y = -19.908, z =  42.265 },
    { x = -214.846, y = -19.320, z =  36.134 },
    { x = -254.938, y = -19.435, z =  34.812 },
    { x = -259.494, y = -20.121, z =  23.333 },
    { x = -257.510, y = -19.278, z =  47.036 },
    { x = -271.910, y = -19.543, z =  63.326 }
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 1800) -- 30 minutes
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 37) -- 109 total weapon damage
    mob:setMod(xi.mod.EVA, 301)
    mob:setMod(xi.mod.ATT, 211)

    -- Despawn the ???
    GetNPCByID(ID.npc.BEHEMOTH_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            target:getXPos() > -180 and target:getZPos() > 53,
            target:getXPos() > -230 and target:getZPos() < 5,
        },
        position = mob:getPos(),
        wait = 3,
    }
    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BEHEMOTHS_BANE)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.BEHEMOTH_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
