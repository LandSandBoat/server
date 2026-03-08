-----------------------------------
-- Ink Jet alt
-- Family: Sea Monk
-- Description: Deals Dark damage to targets in front. Additional Effect: Blind, Knockback
-- Notes: Used by Fe'e in Up in Arms BCNM as a regular attack once all tentacles wounded.
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
    params.primaryMessage = xi.msg.basic.HIT_DMG

    --  TODO: Knockback strength varies based on current HP percentage, becoming extremely weak at low health. 3->2->1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Jimmayus spreadsheet states 30-120s duration. Not sure if resists accounted for, if random, or tp scaling.
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 80, 0, 120)
    end

    return info.damage
end

return mobskillObject
