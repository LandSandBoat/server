-----------------------------------
-- Mijin Gakure
-- Description: Deals unaspected magic damage to targets in range.
-- Note: Behavior of skill differs from players. Example: Not all mobs die after using skill.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Capture fTPs/Formula
    params.baseDamage      = mob:getWeaponDmg() * skill:getMobHPP() / 10 + 6
    params.fTP             = { 1.0, 1.0, 1.0 }
    params.element         = xi.element.NONE
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.ELEMENTAL
    params.shadowBehavior  = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
