-----------------------------------
-- Javelin Throw
-- Family: Mamool Ja
-- Description: Ranged attack with the equipped weapon, which is lost.
-- Notes: Used by armed DRG Mamool Ja
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- If animationSub is non-zero, mob has already lost the weapon.
    if mob:getAnimationSub() == 0 and mob:getMainJob() == xi.job.DRG then -- TODO: Set proper skill lists
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipParry      = true
    params.skipGuard      = true
    params.skipBlock      = true

    local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    skill:setFinalAnimationSub(2)

    return info.damage
end

return mobskillObject
