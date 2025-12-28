-----------------------------------
-- Area: Fei'Yin
--   NM: Southern Shadow
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -153.000, y = -16.000, z =  89.000 },
    { x = -152.000, y = -15.000, z =  77.000 },
    { x = -163.000, y = -15.000, z =  74.000 },
    { x = -166.000, y = -15.000, z =  84.000 }
}

entity.phList =
{
    [ID.mob.SOUTHERN_SHADOW - 3] = ID.mob.SOUTHERN_SHADOW, -- -159.000 -16.000 146.000
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.EVASION_DOWN)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
