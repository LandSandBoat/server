-----------------------------------
-- Entangle (Poison & Enmity Reset Variant)
-- Description: Deals physical damage to a single target. Additional effect : Bind, Poison, Enmity Reset
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 3.0
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:resetEnmity(target)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING, { breakBind = false })
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 50, 3, 180)
    return dmg
end

return mobskillObject
