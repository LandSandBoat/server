-----------------------------------
-- Acheron Flame
-- Family: Cerberus
-- Description: Deals severe Fire damage to enemies within an area of effect. Additional Effect: Burn
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 12.50, 12.50, 12.50 } -- TODO: Captures fTPs
    params.element         = xi.element.FIRE
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.FIRE
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local power = 30 -- TODO: Capture power/duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, power, 3, 60)
    end

    return info.damage
end

return mobskillObject
