-----------------------------------
-- Area: Cloister of Flames
-- Mob: Fire Elemental
-- Quest: Waking the Beast
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGPHYS, -2500)
    mob:setMod(xi.mod.FIRE_ABSORB, 100)
    -- res rank for mob that absorbs is always lowest value
    -- set here as this shares a mob_resistances row with many other eles
    mob:setMod(xi.mod.FIRE_RES_RANK, -3)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PARALYZE)
    -- mob:setMobMod(xi.mobMod.SKIP_ALLEGIANCE_CHECK, 1)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 12)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngage = function(mob, target)
    mob:setMagicCastingEnabled(true)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PLAGUE, { chance = 10, duration = 30, power = 5 })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
