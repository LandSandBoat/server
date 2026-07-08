-----------------------------------
-- Agaricus
-- Family: Funguar
-- Description: Deals physical damage to a single target. Additional Effect: Plague, Slow
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
    params.fTP            = { 3, 3, 3 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 2500, 0, 120) -- TODO: Verify slow chance and duration
    end

    return info.damage
end

return mobskillObject
