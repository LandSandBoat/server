-----------------------------------
-- Drill Claw
-- Family: Meeble
-- Description: Single target physical damage. Additional Effect: Max HP Down, Max TP Down.
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
    params.fTP            = { 2.0, 2.0, 2.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture effect power/durations
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 50, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_TP_DOWN, 50, 0, 60)
    end

    return info.damage
end

return mobskillObject
