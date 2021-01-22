-----------------------------------
-- Area: Mount Zhayolm
--   NM: Ignamoth
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
    mob:setMod(tpz.mod.REGAIN, 200)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {duration = 60})
end

entity.onMobDeath = function(mob)
    tpz.hunts.checkHunt(mob, player, 457)
end

return entity
