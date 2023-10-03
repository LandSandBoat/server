-----------------------------------
-- Area: Beaucedine Glacier (111)
--   NM: Kirata
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 311)
    xi.magian.onMobDeath(mob, player, optParams, set{ 432 })
end

return entity
