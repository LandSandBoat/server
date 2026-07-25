-----------------------------------
-- Area: Toraimarai Canal
--   NM: Oni Carcass
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -375.173, y = 22.000, z = -14.641 },
    { x = -383.021, y = 22.000, z = -12.584 },
    { x = -387.421, y = 22.500, z = -21.603 },
    { x = -380.884, y = 22.000, z = -27.639 },
    { x = -372.914, y = 22.500, z = -21.283 }
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours
end

return entity
