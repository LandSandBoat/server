-----------------------------------
-- Thunder Breath
-- Family: Wyverns
-- Description: Deals Thunder damage to enemies within a fan-shaped area originating from the caster.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        target:isInDynamis() or -- TODO: Set skill lists
        target:hasStatusEffect(xi.effect.BATTLEFIELD)
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.125
    params.damageCap        = 700
    params.bonusDamage      =  math.floor((mob:getMainLvl() + 2) * 1.5)
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.THUNDER
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.THUNDER
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
