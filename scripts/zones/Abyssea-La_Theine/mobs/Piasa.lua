-----------------------------------
-- Area: Abyssea - La Theine
--   NM: Piasa
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
