-----------------------------------
-- Impact Roar
-- Family: Gigas
-- Description: Emits the roar of an impact event, dealing damage in a fan-shaped area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 6.3, 6.3, 6.3 }
    params.element         = xi.element.WIND
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.WIND
    params.shadowBehavior  = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 120)
    end

    return info.damage
end

return mobskillObject
