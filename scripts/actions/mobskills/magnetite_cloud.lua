-----------------------------------
-- Magnetite Cloud
-- Family: Antica
-- Description: Deals Earth damage to enemies within a fan-shaped area originating from the caster. Additional Effect: Weight.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.15
    params.element           = xi.element.EARTH
    params.damageCap         = 509 -- TODO: Capture Cap
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.EARTH)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 75, 0, math.random(30, 60))
    end

    return damage
end

return mobskillObject
