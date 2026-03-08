-----------------------------------
-- Crosswind
-- Family: Puks
-- Description: Deals Wind damage to enemies within a fan-shaped area. Additional Effect: Knockback
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getFamily() == 91 and -- Pandemonium Warden TODO: Set skill lists
        mob:getModelId() ~= 1746
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.0833
    params.damageCap        = 333
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.WIND
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.WIND
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
