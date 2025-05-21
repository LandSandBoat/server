-----------------------------------
-- Area: Behemoth's Dominion
--   NM: Picklix Longindex
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.STUN)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
