-----------------------------------
-- Foxfire
-- Family: Fomor
--  Description: Inflicts conal AoE damage to targets in front of mob. Additional Effect: Stun
-- Notes: Used by: RDM, THF, PLD, BST, BRD, RNG, NIN, and COR fomors (Generally 1 hand weapon types)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

local validJobs = set{
    xi.job.RDM,
    xi.job.THF,
    xi.job.PLD,
    xi.job.BST,
    xi.job.RNG,
    xi.job.BRD,
    xi.job.NIN,
    xi.job.COR,
}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if validJobs[mob:getMainJob()] then -- TODO: Set Proper skill lists
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 15)
    end

    return info.damage
end

return mobskillObject
