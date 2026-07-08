-----------------------------------
-- Pelagic Tempest
-- Family: Murex
-- Description: Delivers a conal AoE attack to targets in front of mob. Additional Effect: Shock, Terror
-- Notes: Used by Murex affiliated with lightning element. Shock effect is fairly strong (28/tick).
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 3.0, 3.0, 3.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture effect powers/durations
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SHOCK, 28, 3, 180)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 1, 0, 180)
    end

    return info.damage
end

return mobskillObject
