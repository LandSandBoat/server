-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Chigre
-----------------------------------
local entity = {}
-- Todo: add enailments, Drain samba on target if all ailments on, very fast enmity decay, capture speed

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.rage, { rageTimer = utils.minutes(60) })
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
