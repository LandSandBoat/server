-----------------------------------
-- Death Scissors
-- Family: Scorpion
-- Description: Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 1
    params.fTP              = { 4.0, 4.0, 4.0 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.SLASHING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier = { 2.5, 2.5, 2.5 }
    params.canCrit          = true
    params.criticalChance   = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

    if mob:getPool() == xi.mobPool.KING_VINEGARROON then
        params.criticalChance = { 1.00, 1.00, 1.00 }
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
