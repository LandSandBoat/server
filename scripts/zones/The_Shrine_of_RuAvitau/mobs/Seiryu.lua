-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Seiryu (Pet version)
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.CANNOT_GUARD, 1)
    mob:setMod(xi.mod.REGAIN, 450)

    mob:addListener('EFFECT_LOSE', 'SEIRYU_HF', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.HUNDRED_FISTS then
            mobArg:setMagicCastingEnabled(true)
            mobArg:setMobAbilityEnabled(true)
        end
    end)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.jsa.HUNDRED_FISTS then
        mob:setMagicCastingEnabled(false)
        mob:setMobAbilityEnabled(false)
    end
end

return entity
