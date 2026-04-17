-----------------------------------
-- Spinal Cleave
-- Family: Qutrub
-- Description: Performs a jumping slash on a single target.
-- Notes: Used only when wielding no weapon, and only when the second weapon is not broken.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.canCrit        = true
    params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
