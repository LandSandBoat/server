-----------------------------------
-- Area: Arrapago Reef
--  ZNM: Lil Apkallu
-----------------------------------
local entity = {}
-- Todo: Apkallu hate, Hundred Fists, Movement and TP pattern

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.rage, { rageTimer = utils.minutes(60) })
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
