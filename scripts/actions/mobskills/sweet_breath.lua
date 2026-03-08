-----------------------------------
-- Sweet Breath
-- Family: Morbol
-- Description: Deals Dark breath damage to enemies within a fan-shaped area originating from the caster.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.0909
    params.damageCap        = 500
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.DARK
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.DARK
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local duration = math.random(15, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, duration)
    end

    return info.damage
end

return mobskillObject
