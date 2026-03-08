-----------------------------------
-- Molting Burst
-- Family: Limules
-- Description: Deals Light damage to . Restores HP of mob. Transfers any negative status effects on the mob to the target.
-- Notes: Used by Limules affiliated with Light element.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 5, 5, 5 } -- TODO: capture fTPs
    params.element        = xi.element.LIGHT
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.LIGHT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Might want to make a new binding to tranfer status effects to other targets based on effect flags.
        -- TODO: This skill also transfers debuffs on the mob to the target.
    end

    return info.damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    xi.mobskills.mobHealMove(mob, mob:getMaxHP() * 0.10) -- TODO: Capture heal power
end

return mobskillObject
