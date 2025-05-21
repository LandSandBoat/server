-----------------------------------
--  Gouging Branch
--  Description: Drills a single target with a branch. Additional effect: Blind
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Melee
--  Notes: Only used by Stcemqestcint
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod  = 1
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.NO_EFFECT, 2.0, 2.0, 2.0)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BLINDNESS, 50, 0, 45)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    return dmg
end

return mobskillObject
