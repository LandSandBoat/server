-----------------------------------
-- Binding Microtube
-- Description: Deals Magic damage to target. Additional Effect: Bind
-- Notes: Used by Adelheid (Trust)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.fTP              = { 6.45, 6.45, 6.45 } -- TODO: Capture fTPs
    params.element          = xi.element.NONE
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.NONE
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType, { breakBind = false })

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60)
    end

    return info.damage
end

return mobskillObject
