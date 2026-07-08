-----------------------------------
-- Water Bomb
-- Family: Poroggo
-- Description: Deals Water damage to enemies within area of effect. Additional Effect: Silence.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 2.00, 2.00, 2.00 }
    params.element         = xi.element.WATER
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.WATER
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
    end

    return info.damage
end

return mobskillObject
