-----------------------------------
-- Ink Jet
-- Family: Sea Monks
-- Description:  Deals Dark damage to targets in front of mob. Additional Effect: Blind
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1.50, 2.00, 2.50 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Jimmayus spreadsheet states 30-120s duration. Not sure if resists accounted for, if random, or tp scaling.
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 80, 0, 120)
    end

    return info.damage
end

return mobskillObject
