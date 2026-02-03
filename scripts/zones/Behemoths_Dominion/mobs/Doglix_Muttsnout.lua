-----------------------------------
-- Area: Behemoth's Dominion
--   NM: Doglix Muttsnout
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.STUN)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 11)
    mob:setMod(xi.mod.STORETP, 200)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
