-----------------------------------
-- Area: Uleguerand Range
--   NM: Bonnacon
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {chance = 65, duration = math.random(5, 15)})
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 319)
end

return entity
