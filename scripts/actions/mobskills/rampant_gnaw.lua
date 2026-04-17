-----------------------------------
-- Rampant Gnaw
-- Family: Buffalo
-- Description: Deals damage to a single target. Additional Effect: Paralysis
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
    params.fTP              = { 1.7, 1.7, 1.7 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.BLUNT
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier = { 1.5, 1.5, 1.5 }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, 120)
    end

    return info.damage
end

return mobskillObject
