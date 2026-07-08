-----------------------------------
-- Chaos Blade
-- Family: Dragons
-- Description: Deals Dark damage to enemies within a fan-shaped area. Additional Effect: Curse
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1, 1, 1 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    -- TODO: This move should force the mob to look at the target.

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/durations (Varies between different mobs/NMs)
        local power    = 25
        local duration = 420

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, power, 0, duration)
    end

    return info.damage
end

return mobskillObject
