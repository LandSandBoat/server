-----------------------------------
-- Sandspin
-- Family: Worms
-- Description: Deals Earth damage to enemies around mob. Additional Effect: Accuracy Down.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.element        = xi.element.EARTH
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.EARTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, 25, 0, 180)
    end

    return info.damage
end

return mobskillObject
