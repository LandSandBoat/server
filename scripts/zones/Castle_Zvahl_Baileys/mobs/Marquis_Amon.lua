-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Marquis Amon
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(900, 10800))
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDespawn = function(mob)
    -- Set Marquis_Amon's spawnpoint and respawn time (21-24 hours)
    mob:setRespawnTime(math.randomInt(75600, 86400))
end

return entity
