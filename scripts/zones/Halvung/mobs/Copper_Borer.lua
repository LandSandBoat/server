-----------------------------------
-- Area: Halvung
--   NM: Copper Borer
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)

    -- probably tops out at 50 dmg for a 75 player, max dmg seen as naked lv99 was 36
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 35, 0, 0)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE, { chance = 100, power = 35 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 465)
end

return entity
