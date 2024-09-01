-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Ob
-----------------------------------
local entity = {}
-- Todo: Pups can make it change frames, Overload causes Rage

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.rage, { rageTimer = utils.minutes(60) })
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
