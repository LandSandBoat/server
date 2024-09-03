-----------------------------------
-- Area: Aydeewa Subterrane
--  Mob: Fossorial Flea
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PLAGUE, { chance = 10 })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
