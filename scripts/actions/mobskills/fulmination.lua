-----------------------------------
-- Fulmination
-- Family: Khimaira
-- Description: Deals Thunder damage in an area of effect. Additional Effect: Paralysis, Stun
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 12, 12, 12 } -- TODO: Capture fTPs
    params.element        = xi.element.THUNDER
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.THUNDER
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/durations
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 40, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)
    end

    return info.damage
end

return mobskillObject
