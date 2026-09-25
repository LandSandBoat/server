-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Grand Duke Batym
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Demons_Elemental')
    mob:setRespawnTime(math.randomInt(900, 10800))
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDespawn = function(mob)
    -- Set Grand_Duke_Batym's spawnpoint and respawn time (21-24 hours)
    mob:setRespawnTime(math.randomInt(75600, 86400))
end

return entity
