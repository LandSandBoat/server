-----------------------------------
-- Shadow Burst
-- Family: Gargouille
-- Description: Deals Dark damage to enemies within area of effect. Additional Effect: Curse
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: Animation looks like it is meant to be used in standing form. Need captures.
    if mob:getAnimationSub() ~= 0 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.00, 2.00, 2.00 } -- TODO: Capture fTPs
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 50, 0, 300)
    end

    return info.damage
end

return mobskillObject
