-----------------------------------
-- Area: Cloister of Frost
-- Mob: Ice Elemental
-- Quest: Waking the Beast
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGPHYS, -2500)
    mob:setMod(xi.mod.ICE_ABSORB, 100)
    -- res rank for mob that absorbs is always lowest value
    -- set here as this shares a mob_resistances row with many other eles
    mob:setMod(xi.mod.ICE_RES_RANK, -3)
    mob:setMobMod(xi.mobMod.SKIP_ALLEGIANCE_CHECK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 12)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngage = function(mob, target)
    mob:setMagicCastingEnabled(true)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 10,
        effectId = xi.effect.PARALYSIS,
        power    = 20,
        duration = 30,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
