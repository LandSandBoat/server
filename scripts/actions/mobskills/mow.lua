-----------------------------------
-- Mow
-- Family: Tauri
-- Description: Deals damage in an area of effect. Additional Effect: Poison
-- Notes: Poison can take around 10HP/tick
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3
    params.fTP            = { 0.5, 0.5, 0.5 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior
    params.canCrit        = true
    params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

    -- Notes: Fairly certain this ia a multi hit. Damage logs show at least 2 hit minimum, also got multiple skill ups of the same type from it.
    -- 2 seperate Evasion skill ups + 1 parry skill up so likely 2 or 3 hit?

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 25, 3, 30)
    end

    return info.damage
end

return mobskillObject
