-----------------------------------
-- Roller Chain
-- Family: Ramparts
-- Description: Deals Physical damage to a target. Additional Effect: Bind.
-- Notes: Only used by Ramparts when its door is closed.
-----------------------------------

---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: This is a physical skill. Will revisit in mobPhysicalMove() PR
    params.baseDamage     = mob:getWeaponDmg()
    params.fTP            = { 2, 2, 2 } -- TODO: Capture fTPs
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/durations
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)
    end

    return info.damage
end

return mobskillObject
