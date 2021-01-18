-----------------------------------
-- Area: Fei'Yin
--   NM: Southern Shadow
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.EVA_DOWN)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
