-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Shii
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 20) -- "also has an Auto Regen of medium strength" (guessing 20)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1) -- "has an Additional Effect: Terror in melee attacks"
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 179)
end

return entity
