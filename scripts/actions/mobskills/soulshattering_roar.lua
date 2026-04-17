-----------------------------------
-- Soulshattering Roar
-- Family: Yztarg
-- Description: Deals (TODO: Physical/Magical?) damage to enemies in range of mob. Additional Effect: Terror
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 8.00, 8.00, 8.00 } -- TODO: Capture fTPs
    params.element        = xi.element.DARK      -- TODO: Capture element if skill is a magicalMove
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    -- TODO: Capture Skill range and AoE Radius

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 1, 0, 30) -- TODO: Capture duration
    end

    -- TODO: Temporary immunity to a single weapon damage type
    -- Note: This should probably be handled in a mixin or within the mob script.

    return info.damage
end

return mobskillObject
