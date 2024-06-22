-----------------------------------
-- Area: Jugner_Forest
--   NM: Giollemitte_B_Feroun
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
