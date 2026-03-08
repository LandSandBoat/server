-----------------------------------
-- Tidal Slash
-- Family: Lamia
-- Description: Deals physical damage to enemies in front of mob.
-- Notes: Only used when wielding a spear.
-- Zanshin auto attack can proc on this.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getAnimationSub() ~= 1 and
        mob:getMainJob() == xi.job.SAM -- TODO: Set proper skill lists
    then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: This is a physical skill, will fix in mobPhysicalMove() PR
    params.baseDamage     = mob:getWeaponDmg()
    params.fTP            = { 1.5, 1.5, 1.5 }
    params.element        = xi.element.WATER
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WATER
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
