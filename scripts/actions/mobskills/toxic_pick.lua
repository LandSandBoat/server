-----------------------------------
-- Toxic Pick
-- Family: Cockatrice
-- Description: Deals damage to a single target. Additional Effect: Gravity, Plague, Poison
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local power = mob:getMainLvl() / 2
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 180)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 75, 0, 120)
    end

    return info.damage
end

return mobskillObject
