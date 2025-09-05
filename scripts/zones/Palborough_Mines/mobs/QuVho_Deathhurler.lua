-----------------------------------
-- Area: Palborough Mines
--   NM: Qu'Vho Deathhurler
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  124.000, y = -15.000, z =  242.000 },
    { x =  120.000, y = -15.000, z =  238.000 },
    { x =  128.000, y = -15.000, z =  249.000 },
    { x =  121.000, y = -15.000, z =  245.000 },
    { x =  115.000, y = -15.000, z =  246.000 },
}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 33)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 221)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200))
end

return entity
