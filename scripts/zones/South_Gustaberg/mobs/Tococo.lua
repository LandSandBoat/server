-----------------------------------
-- Area: South Gustaberg
--   NM: Tococo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  -53.000, y =   0.000, z =  -197.000 },
    { x = -116.000, y =   0.000, z =  -202.000 },
    { x = -115.000, y =   0.000, z =  -181.000 },
    { x =  -84.000, y =   0.000, z =  -196.000 },
    { x =  -68.000, y =   0.900, z =  -214.000 },
    { x =  -81.000, y =   1.900, z =  -178.000 },
    { x =  -79.000, y =   0.000, z =  -166.000 },
    { x =  -71.000, y =  10.000, z =  -238.000 },
    { x = -133.000, y =   7.840, z =  -228.000 },
    { x =  -99.000, y =  12.000, z =  -235.000 },
    { x =  -53.000, y =   0.000, z =  -197.000 },
    { x = -116.000, y =   0.000, z =  -202.000 },
    { x = -115.000, y =   0.000, z =  -181.000 },
    { x =  -84.000, y =   0.000, z =  -196.000 },
    { x =  -68.000, y =   0.900, z =  -214.000 },
    { x =  -81.000, y =   1.900, z =  -178.000 },
    { x =  -79.000, y =   0.000, z =  -166.000 },
    { x =  -71.000, y =  10.000, z =  -238.000 },
    { x = -133.000, y =   7.840, z =  -228.000 },
    { x =  -99.000, y =  12.000, z =  -235.000 },
    { x =  -53.000, y =   0.000, z =  -197.000 },
    { x = -116.000, y =   0.000, z =  -202.000 },
    { x = -115.000, y =   0.000, z =  -181.000 },
    { x =  -84.000, y =   0.000, z =  -196.000 },
    { x =  -68.000, y =   0.900, z =  -214.000 },
    { x =  -81.000, y =   1.900, z =  -178.000 },
    { x =  -79.000, y =   0.000, z =  -166.000 },
    { x =  -71.000, y =  10.000, z =  -238.000 },
    { x = -133.000, y =   7.840, z =  -228.000 },
    { x =  -99.000, y =  12.000, z =  -235.000 },
    { x =  -53.000, y =   0.000, z =  -197.000 },
    { x = -116.000, y =   0.000, z =  -202.000 },
    { x = -115.000, y =   0.000, z =  -181.000 },
    { x =  -84.000, y =   0.000, z =  -196.000 },
    { x =  -68.000, y =   0.900, z =  -214.000 },
    { x =  -81.000, y =   1.900, z =  -178.000 },
    { x =  -79.000, y =   0.000, z =  -166.000 },
    { x =  -71.000, y =  10.000, z =  -238.000 },
    { x = -133.000, y =   7.840, z =  -228.000 },
    { x =  -99.000, y =  12.000, z =  -235.000 },
    { x =  -53.000, y =   0.000, z =  -197.000 },
    { x = -116.000, y =   0.000, z =  -202.000 },
    { x = -115.000, y =   0.000, z =  -181.000 },
    { x =  -84.000, y =   0.000, z =  -196.000 },
    { x =  -68.000, y =   0.900, z =  -214.000 },
    { x =  -81.000, y =   1.900, z =  -178.000 },
    { x =  -79.000, y =   0.000, z =  -166.000 },
    { x =  -71.000, y =  10.000, z =  -238.000 },
    { x = -133.000, y =   7.840, z =  -228.000 },
    { x =  -99.000, y =  12.000, z =  -235.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200)) -- When server restarts, reset timer
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 5, duration = math.random(5, 15) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 201)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200)) -- 60 to 70 minutes
end

return entity
