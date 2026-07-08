-----------------------------------
-- Hiemal Storm
-- Family: Snoll
-- Description: Extreme directional AoE ice damage for 200-1400 points
-- Notes: Used by Snoll Tzar
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.382 -- TODO: Capture value.
    params.damageCap        = 1300 -- TODO: Capture damage cap.
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.ICE
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.ICE
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    info.damage = utils.conalDamageAdjustment(mob, target, skill, info.damage, 0.9) -- TODO: Does this have a conal adjustment?

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
