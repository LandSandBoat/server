-----------------------------------
-- Blazing Bound
-- Family: Limules
-- Description: Deals Fire damage to target. Additional Effect: Burn
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 3.00, 3.00, 3.00 } -- TODO: Capture fTPs
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/durations/ if it scales on level/tp
        -- xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 25, 0, 120) -- Need power/duration data
        -- xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, 25, 0, 120) -- Need power/duration data
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, 26, 3, 120)
    end

    return info.damage
end

return mobskillObject
