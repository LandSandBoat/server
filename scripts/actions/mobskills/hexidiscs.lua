-----------------------------------
-- Hexidiscs
-- Family: Ghrah
-- Description: A sixfold attack damages targets in a fan-shaped area of effect.
-- Notes: Only used in "ball" form.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() ~= 0 then -- Only used in ball form
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 6
    params.fTP              = { 0.5, 0.5, 0.5 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.BLUNT -- TODO: Capture damageType
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_6 -- TODO: Capture shadowBehavior
    params.attackMultiplier = { 1.25, 1.25, 1.25 }
    params.accuracyModifier = { -50, -50, -50 } -- TODO: Capture accuracy modifier

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
