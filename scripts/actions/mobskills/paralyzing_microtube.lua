-----------------------------------
-- Paralyzing Microtube
-- Description: Deals Magic damage to target. Additional effect: Paralyze
-- Used by Adelheid (Trust)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.fTP            = { 12.25, 12.25, 12.25 } -- TODO: Capture fTPs
    params.element        = xi.element.NONE         -- TODO: Capture element
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.NONE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, 60) -- TODO: Capture power/duration
    end

    return info.damage
end

return mobskillObject
