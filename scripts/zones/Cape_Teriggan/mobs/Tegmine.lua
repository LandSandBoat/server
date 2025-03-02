-----------------------------------
-- Area: Cape Teriggan
--   NM: Tegmine
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -11.082, y = -1.124, z = -109.332 },
    { x =  -1.728, y =  0.295, z = -110.063 },
    { x =   4.875, y =  0.042, z = -119.958 },
    { x =   2.422, y = -0.614, z = -129.876 },
    { x =  -5.618, y = -0.341, z = -124.383 },
    { x = -11.142, y = -2.023, z = -123.280 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(7200, 7800)) -- 120 to 130 min
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.ATT, 50)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.STUN)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 404)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(7200, 7800)) -- 120 to 130 min
end

return entity
