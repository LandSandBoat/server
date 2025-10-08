-----------------------------------
-- Radiant Breath
-- Family: Wyverns
-- Description: Deals Light damage to enemies within a fan-shaped area of effect originating from the mob. Additional Effect: Silence, Slow
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.125
    params.element           = xi.element.LIGHT
    params.damageCap         = 700
    params.bonusDamage       = (mob:getMainLvl() + 2) * 2
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT -- TODO: Light based skills are often MND, need captures.

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.LIGHT)

         -- TODO: Function name is duration. We might want to rename to something more universal.
        local power = xi.mobskills.calculateDuration(skill:getTP(), 1250, 1250) -- TODO: Capture power values

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, power, 0, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 120)
    end

    return damage
end

return mobskillObject
