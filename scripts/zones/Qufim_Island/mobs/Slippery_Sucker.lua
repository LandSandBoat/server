-----------------------------------
-- Area: Qufim Island
--   NM: Slippery Sucker
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 308)
end

return entity
