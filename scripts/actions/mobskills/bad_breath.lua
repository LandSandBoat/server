-----------------------------------
-- Bad Breath
-- Family: Morbol
-- Description: Deals Earth damage that inflicts multiple status ailments on enemies within a fan-shaped area originating from the caster.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.12
    params.element           = xi.element.EARTH
    params.damageCap         = 500 -- TODO: Capture cap
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT
    -- TODO: Sources say this skill has a low magic accuracy.

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.EARTH, { breakBind = false })

        -- TODO: Capture power/durations of various effects.
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 1, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 15, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 60)
    end

    return damage
end

return mobskillObject
