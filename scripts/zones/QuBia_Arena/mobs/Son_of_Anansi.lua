-----------------------------------
-- Area: Qu'Bia_Arena
--  Mob: Son of Anansi
-- KSNM: Come Into My Parlor
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { chance = 20, power = 50, duration = 40 })
end

return entity
