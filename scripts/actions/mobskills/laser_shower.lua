-----------------------------------
-- Laser Shower
-- Famnily: Omega
-- Description: Fires several lasers into a fan-shaped area of effect. Additional Effect: Defense Down
-- Notes: Used by Proto Omega and Pantokrator
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.20 -- TODO: Capture Value
    params.element           = xi.element.LIGHT
    params.damageCap         = 1600
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    local dis = ((mob:checkDistance(target) * 2) / 20) -- TODO: Verify this skill has a damage adjustment based on range from mob.

    damage = damage * dis
    damage = utils.clamp(damage, 50, 1600)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.LIGHT)

        -- TODO: Capture effect power/duration
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 25, 0, 60)
    end

    return damage
end

return mobskillObject
