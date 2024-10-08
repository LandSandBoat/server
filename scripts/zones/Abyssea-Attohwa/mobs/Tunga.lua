-----------------------------------
-- Area: Abyssea-Attohwa
--   NM: Tunga
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_nm') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { chance = 10, power = 130 })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
