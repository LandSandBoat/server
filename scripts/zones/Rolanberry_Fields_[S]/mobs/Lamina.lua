-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Lamina
-- Note: https://www.bg-wiki.com/ffxi/Lamina
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  51.54, y = 23.25, z = 518.33 },
    { x =  56.75, y = 23.29, z = 525.66 },
    { x =  62.24, y = 23.87, z = 531.99 },
    { x =  66.25, y = 23.91, z = 536.18 },
    { x =  70.29, y = 23.94, z = 540.39 },
    { x =  76.77, y = 24.15, z = 541.61 },
    { x =  83.24, y = 23.86, z = 550.22 },
    { x = 105.64, y = 20.10, z = 436.23 },
    { x = 114.36, y = 22.57, z = 445.11 },
    { x = 122.17, y = 23.56, z = 456.38 },
    { x = 110.18, y = 23.36, z = 467.20 },
    { x =  92.57, y = 23.57, z = 480.25 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes

    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 115)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW, { chance = 5, duration = 30, power = 10 })
end

entity.onMobMobskillChoose = function(mob, target)
    return xi.mobSkill.PEDAL_PIROUETTE -- Petal Pirouette is only TP move
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 510)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
