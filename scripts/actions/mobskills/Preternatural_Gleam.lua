-----------------------------------
-- Preternatural Gleam
-- Family: Coeurl
-- Description: Deals Light damage to enemies in a fan-shaped area originating from caster. Additional Effect: Mute, Paralysis
-- Notes: Used by Cath Palug
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1.5, 1.5, 1.5 } -- TODO: Capture fTPs
    params.element        = xi.element.LIGHT -- TODO: Capture element
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.LIGHT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS -- TODO: Capture shadowBehavior
    -- TODO: Capture range and animation

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MUTE, 1, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 70, 0, 60)
    end

    return info.damage
end

return mobskillObject
