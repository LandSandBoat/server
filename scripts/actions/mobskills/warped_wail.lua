-----------------------------------
-- Warped Wail
-- Family: Amphipteres
-- Description: Deals Wind damage to targets in range. Additional Effect: Max HP Down, Max MP Down
-- Notes: Used by Zirnitra and Pteranodon
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
    params.element        = xi.element.WIND      -- TODO: Capture element.
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WIND
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO Capture power/duration of HP/MP Down.
        -- From found battle footage, it looks to be around 10-15%. (Hard to tell exact since player was gear swapping).
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 50, 0, 300)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_MP_DOWN, 50, 0, 300)
    end

    return info.damage
end

return mobskillObject
