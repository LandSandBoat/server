-----------------------------------
-- Area: Attohwa Chasm
--   NM: Sekhmet
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.FASTCAST, 15)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, { power = math.random(1, 10) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 276)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(6, 8) * 900) -- 1.5 to 2 hours in 15 minute windows
end

return entity
