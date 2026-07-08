-----------------------------------
-- Sub-Zero Smash
-- Family: Ruszor
-- Description: Additional Effect: Paralysis. Damage varies with TP.
-- Range: Cone (5' yalms)
-- Notes: This spell should be used anytime the target is behind the mob.
--        However the online documentation suggests that this spell can
--        still be used anytime. As a result, any other Ruszor spells
--        should not trigger if the target is behind the mob.
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
    params.fTP            = { 1.0, 1.0, 1.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 10, 0, 100) -- TODO: Capture power/duration
    end

    return info.damage
end

return mobskillObject
