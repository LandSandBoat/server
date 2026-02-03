-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Huu Xalmo the Savage
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STUN_RES_RANK, 11)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 11)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
