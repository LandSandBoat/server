-----------------------------------
-- Gusting Gouge
-- Family: Lamia
-- Description: Deals physical damage in a threefold attack to targets in a fan-shaped area of effect.
-- Notes: Used by Lamia equipped with a one-handed weapon(Dagger). If they lost their weapon, they'll use Hysteric Barrage instead.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getAnimationSub() ~= 1 and
        (
            mob:getMainJob() == xi.job.COR or -- TODO: Set proper skill lists
            mob:getMainJob() == xi.job.BRD or
            mob:getMainJob() == xi.job.RDM
        )
    then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3 -- TODO: Confirm numHits
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING -- TODO: Capture damageType
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
