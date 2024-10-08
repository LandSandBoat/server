-----------------------------------
-- Area: The Eldieme Necropolis [S] (175)
--  Mob: Chigoe
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
