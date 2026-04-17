-----------------------------------
-- Shackled Fists
-- Family: Fomor
-- Description: Delivers a fivefold attack.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getMainJob() == xi.job.MNK then -- TODO: Set proper skill lists
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 5
    params.fTP            = { 0.5, 0.5, 0.5 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_5

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
