-----------------------------------
-- Impale
-- Family: Morbol
-- Description: Deals damage to a single target. Additional Effect: Paralysis (NM version AE applies a strong poison effect and resets enmity on target)
-- Utsusemi/Blink absorb: 1 shadow (NM version ignores shadows)
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
    params.fTP              = { 1.0, 1.0, 1.0 } -- TODO: Capture fTPs
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier = { 2.0, 2.0, 2.0 }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

         -- TODO: We should probably split mobskill varients up like we do with Treant skills. Example: impale_paralysis, impale_poison, etc
        local typeEffect = xi.effect.PARALYSIS
        if mob:isMobType(xi.mobType.NOTORIOUS) then
            -- TODO: Capture hate reset type (Enmity wipe vs enmity turned off)
            -- See Antica skill "Sand Trap" for reference
            mob:resetEnmity(target)
            typeEffect = xi.effect.POISON
        end

        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 120)
    end

    return info.damage
end

return mobskillObject
