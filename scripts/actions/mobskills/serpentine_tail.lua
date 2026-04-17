-----------------------------------
-- Serpentine Tail
-- Family: Hydra
-- Description: Deals heavy damage to a target behind the user.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return target:isBehind(mob, 48) and 0 or 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 4.25, 4.25, 4.25 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
