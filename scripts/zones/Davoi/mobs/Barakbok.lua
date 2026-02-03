-----------------------------------
-- Area: Davoi
--  Mob: Barakbok
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 9)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
