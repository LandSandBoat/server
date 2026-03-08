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

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.20 -- TODO: Capture Value
    params.damageCap        = 1600
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.LIGHT
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.LIGHT
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    local distance = ((mob:checkDistance(target) * 2) / 20) -- TODO: Verify this skill has a damage adjustment based on range from mob.
    info.damage = info.damage * distance
    info.damage = utils.clamp(info.damage, 50, 1600)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture effect power/duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 25, 0, 60)
    end

    return info.damage
end

return mobskillObject
