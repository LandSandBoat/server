-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Legalox Heftyhind
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 75) -- "Has a high but not 100% Double Attack rate."
end

entity.onMobSpawn = function(mob)
    mob:addStatusEffect(xi.effect.STONESKIN, 100, 0, 300) -- "Spawns with the effect of Stoneskin."
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW) -- "Physical attacks have an additional effect: Slow, but does not always activate."
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 292)
end

return entity
