-----------------------------------
-- Broadside Barrage
-- Family: Lesser Bird
-- Description: Deals physical damage to a single target. Additional Effect: INT Down, MND Down
-- Notes: Notorious Monster/Nightmare version deals damage in a 10 yalm area of effect around target.
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
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.canCrit        = true
    params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

    -- TODO: AOE Version may take more shadows since it is AoE

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local power = 3 + math.floor(mob:getMainLvl() / 5)

        -- Note: Status effects do not decay.
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, power, 0, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, power, 0, 120)
    end

    return info.damage
end

return mobskillObject
