-----------------------------------
-- Area: Davoi
--  Mob: Deloknok
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.SLEEP_MEVA, 90)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
