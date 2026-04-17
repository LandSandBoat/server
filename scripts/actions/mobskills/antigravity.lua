-----------------------------------
-- Antigravity
-- Family: Gear (Single Gear)
-- Description: Deals Light damage to targets in range. Additional Effect: Knockback
-- Note: Used by Gears that spawn with only a single gear, not the model with 3 gears.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 2.0, 2.0, 2.0 }
    params.element         = xi.element.LIGHT
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.LIGHT
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
