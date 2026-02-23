-----------------------------------
-- Area: Cloister of Storms
--  Mob: Thunder Gremlin
-- Involved in Quest: Carbuncle Debacle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngage = function(mob)
    mob:setMagicCastingEnabled(true) -- Thunder Gremlin does not self buff before engaging
    mob:setMod(xi.mod.BIND_RES_RANK, 4)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 4)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, { chance = 255, power = math.random(25, 38) })
end

return entity
