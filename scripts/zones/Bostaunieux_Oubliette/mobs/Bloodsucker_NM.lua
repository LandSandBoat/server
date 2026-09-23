-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Bloodsucker NM
-- !pos -96.875 16.999 -277.037 167
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1) -- "Has an Additional Effect of Drain on normal attacks"
    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setRespawnTime(3600) -- 1 hour
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 35, power = math.randomInt(1, 135) }) -- Power of 135 but should be subject to resist. Additional effects need further updates before this can happen.
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 613, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
end

return entity
