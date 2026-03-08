-----------------------------------
-- Rail Cannon (3/3 Gears)
-- Family: Gears
-- Description: 3/3 Gears: Rail Cannon is AoE and strips Utsusemi
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 5.0, 5.0, 5.0 }
    params.element         = xi.element.LIGHT
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.LIGHT
    params.shadowBehavior  = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.dStatMultiplier = 1.5

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
