-----------------------------------
-- Crippling Slam
-- Family: Wivre
-- Description: Deals severe damage to targets in front of it by slamming into them. Additional effect: Paralysis.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isInfront(mob) then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 4.0, 4.0, 4.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING -- TODO: Capture damageType
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local duration = xi.mobskills.calculateDuration(skill:getTP(), 30, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, duration)
    end

    return info.damage
end

return mobskillObject
