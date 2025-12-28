-----------------------------------
-- Area: Dragons Aery
--  HNM: Nidhogg
-----------------------------------
local ID = zones[xi.zone.DRAGONS_AERY]
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Spawn points are for era hnm spawns
entity.spawnPoints =
{
    { x =  78.000, y =  6.000, z =  34.000 },
    { x =  75.153, y =  6.898, z =  30.480 },
    { x =  72.493, y =  6.951, z =  41.853 },
    { x =  82.686, y =  6.937, z =  31.458 },
    { x =  71.418, y =  6.915, z =  35.969 },
    { x =  88.992, y =  6.865, z =  44.696 },
    { x =  85.853, y =  6.446, z =  30.419 },
    { x =  72.627, y =  6.613, z =  44.942 },
    { x =  74.025, y =  6.594, z =  46.610 },
    { x =  74.218, y =  6.794, z =  41.864 },
    { x =  73.858, y =  6.545, z =  46.886 },
    { x =  73.786, y =  6.420, z =  51.146 },
    { x =  83.430, y =  6.737, z =  44.652 },
    { x =  76.225, y =  6.847, z =  48.466 },
    { x =  70.107, y =  6.248, z =  47.561 },
    { x =  85.508, y =  6.623, z =  43.494 },
    { x =  77.142, y =  6.825, z =  40.907 },
    { x =  74.067, y =  6.821, z =  37.259 },
    { x =  82.237, y =  6.763, z =  35.132 },
    { x =  72.688, y =  6.720, z =  43.621 },
    { x =  82.761, y =  6.785, z =  35.053 },
    { x =  80.494, y =  6.945, z =  47.438 },
    { x =  73.770, y =  6.365, z =  49.359 },
    { x =  82.622, y =  6.777, z =  29.484 },
    { x =  81.958, y =  6.955, z =  47.541 },
    { x =  79.817, y =  6.788, z =  45.389 },
    { x =  78.207, y =  6.760, z =  28.980 },
    { x =  79.224, y =  6.797, z =  45.597 },
    { x =  71.695, y =  7.364, z =  28.605 },
    { x =  74.758, y =  6.781, z =  40.516 },
    { x =  70.716, y =  6.820, z =  38.822 },
    { x =  79.649, y =  6.781, z =  43.343 },
    { x =  86.509, y =  6.860, z =  41.554 },
    { x =  81.583, y =  6.918, z =  31.452 },
    { x =  86.992, y =  6.529, z =  33.554 },
    { x =  77.566, y =  6.819, z =  49.430 },
    { x =  73.854, y =  7.011, z =  31.457 },
    { x =  81.441, y =  6.883, z =  46.760 },
    { x =  83.537, y =  6.868, z =  47.920 },
    { x =  72.568, y =  6.945, z =  38.623 },
    { x =  79.020, y =  6.862, z =  37.547 },
    { x =  75.409, y =  6.957, z =  31.002 },
    { x =  79.319, y =  6.737, z =  35.703 },
    { x =  69.453, y =  6.270, z =  47.023 },
    { x =  71.454, y =  6.432, z =  46.449 },
    { x =  70.461, y =  6.786, z =  39.996 },
    { x =  83.727, y =  6.865, z =  33.962 },
    { x =  85.741, y =  6.550, z =  28.235 },
    { x =  81.548, y =  6.710, z =  44.110 },
    { x =  88.734, y =  6.894, z =  38.870 }
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 48) -- 140 total weapon damage
    mob:setMod(xi.mod.ATT, 445)
    mob:setMod(xi.mod.ACC, 444)
    mob:setMod(xi.mod.EVA, 327)
    mob:setMod(xi.mod.REGEN, 20) -- Regen assumed to be at least as strong as Fafnir, please recapture.

    -- Despawn the ???
    GetNPCByID(ID.npc.FAFNIR_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobFight = function(mob, target)
    local battletime = mob:getBattleTime()
    local twohourTime = mob:getLocalVar('twohourTime')

    if twohourTime == 0 then
        mob:setLocalVar('twohourTime', math.random(30, 90))
    end

    if battletime >= twohourTime then
        mob:useMobAbility(1053) -- Legitimately captured super_buff ID
        mob:setLocalVar('twohourTime', battletime + math.random(60, 120))
    end

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
    player:addTitle(xi.title.NIDHOGG_SLAYER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.FAFNIR_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
