-----------------------------------
-- Area: Alzadaal Undersea Ruins (72)
--   NM: Cookieduster Lipiroon
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {power = 70})
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 477)
end

return entity
