-----------------------------------
-- Fluid Toss (Claret)
-- Family: Slime (Clot)
-- Description: Lobs a ball of liquid at a single target.
-- Notes: Applies 100hp/tick poison if it hits.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Physical or Ranged PDIF?
    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 1
    params.fTP              = { 1.5, 1.5, 1.5 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.SLASHING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier = { 2.0, 2.0, 2.0 }
    params.canCrit          = true
    params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture effect duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 100, 3, math.random(3, 6) * 3)  -- 3-6 ticks
    end

    return info.damage
end

return mobskillObject
