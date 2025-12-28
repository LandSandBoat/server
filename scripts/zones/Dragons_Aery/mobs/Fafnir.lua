-----------------------------------
-- Area: Dragons Aery
--  HNM: Fafnir
-----------------------------------
local ID = zones[xi.zone.DRAGONS_AERY]
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Spawn points are for era hnm spawns
entity.spawnPoints =
{
    { x =  78.000, y =  6.000, z =  39.000 },
    { x =  77.071, y =  6.830, z =  49.523 },
    { x =  76.578, y =  6.838, z =  45.602 },
    { x =  75.966, y =  6.808, z =  49.096 },
    { x =  76.954, y =  6.807, z =  38.122 },
    { x =  80.965, y =  6.868, z =  42.384 },
    { x =  81.468, y =  6.751, z =  50.467 },
    { x =  83.394, y =  6.822, z =  37.243 },
    { x =  70.539, y =  6.788, z =  38.241 },
    { x =  87.661, y =  6.520, z =  34.198 },
    { x =  75.645, y =  6.749, z =  35.790 },
    { x =  72.633, y =  6.541, z =  46.110 },
    { x =  80.314, y =  6.788, z =  43.262 },
    { x =  72.263, y =  6.500, z =  46.213 },
    { x =  86.844, y =  6.658, z =  35.538 },
    { x =  79.370, y =  6.800, z =  34.151 },
    { x =  70.843, y =  6.837, z =  41.976 },
    { x =  89.395, y =  6.805, z =  39.952 },
    { x =  88.030, y =  6.988, z =  39.351 },
    { x =  86.059, y =  6.683, z =  36.147 },
    { x =  68.200, y =  6.471, z =  45.104 },
    { x =  88.831, y =  6.666, z =  35.991 },
    { x =  76.047, y =  6.859, z =  29.836 },
    { x =  75.376, y =  6.757, z =  37.572 },
    { x =  78.282, y =  6.937, z =  31.587 },
    { x =  74.620, y =  6.688, z =  43.669 },
    { x =  71.115, y =  6.874, z =  39.345 },
    { x =  79.657, y =  6.750, z =  35.427 },
    { x =  69.902, y =  6.705, z =  42.077 },
    { x =  83.039, y =  6.842, z =  47.133 },
    { x =  70.701, y =  6.112, z =  48.573 },
    { x =  87.368, y =  6.887, z =  43.054 },
    { x =  87.497, y =  6.950, z =  40.250 },
    { x =  79.854, y =  6.701, z =  29.823 },
    { x =  80.822, y =  6.905, z =  47.002 },
    { x =  89.650, y =  6.770, z =  41.123 },
    { x =  83.556, y =  6.867, z =  31.715 },
    { x =  90.002, y =  6.667, z =  37.252 },
    { x =  81.332, y =  6.908, z =  40.101 },
    { x =  83.983, y =  6.722, z =  38.491 },
    { x =  84.031, y =  6.753, z =  45.983 },
    { x =  81.171, y =  6.908, z =  41.793 },
    { x =  78.138, y =  6.773, z =  34.914 },
    { x =  88.014, y =  6.769, z =  46.911 },
    { x =  81.764, y =  6.908, z =  39.900 },
    { x =  79.750, y =  6.826, z =  46.203 },
    { x =  82.875, y =  6.808, z =  46.375 },
    { x =  86.300, y =  6.752, z =  42.655 },
    { x =  72.623, y =  7.035, z =  31.974 },
    { x =  78.287, y =  6.770, z =  45.003 }
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 48) -- 140 total weapon damage
    mob:setMod(xi.mod.ATT, 435)
    mob:setMod(xi.mod.REGEN, 20) -- 1% every 90s

    -- Despawn the ???
    GetNPCByID(ID.npc.FAFNIR_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            target:getXPos() > 95 and target:getZPos() > 56,
            target:getXPos() < 60 and target:getZPos() < 23,
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
    player:addTitle(xi.title.FAFNIR_SLAYER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.FAFNIR_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
