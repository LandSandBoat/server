-----------------------------------
-- Area: FeiYin
--  Mob: Miser Murphy
--  Quest: Peace for the Spirit
-----------------------------------
require("scripts/globals/regimes")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, {power = math.random(450, 550)})
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
