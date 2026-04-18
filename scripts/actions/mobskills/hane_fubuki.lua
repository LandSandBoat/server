-----------------------------------
-- Hane Fubuki
-- Family: Yagudo
-- Description: Deals physical damage to a target. Additional Effect: Poison
-- Notes: Similar to "Feather Storm" skill
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Physical or Ranged?
    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    -- TODO: "Feather Storm" scales with distance. Check if this does as well.

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture effect power/duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 3, 3, 45)
    end

    return info.damage
end

return mobskillObject
