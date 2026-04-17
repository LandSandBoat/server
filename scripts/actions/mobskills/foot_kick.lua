-----------------------------------
-- Foot Kick
-- Family: Rabbit
-- Description: Deals critical damage to a single target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getWeaponDmg()
    params.numHits         = 1
    params.fTP             = { 1.0, 1.0, 1.0 }
    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.SLASHING
    params.shadowBehavior  = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.canCrit         = true
    params.criticalChance  = { 1.0, 1.0, 1.0 }

    if mob:getMainLvl() >= 50 then
        params.fTP = { 2, 2, 2 }
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
