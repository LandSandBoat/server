-----------------------------------
--  Primal Drill
--
--  Description: Drills into nearby targets with appendages. Additional effect: Bind
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Unknown radial
--  Notes:
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = .8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    local typeEffect = xi.effect.BIND
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 45)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
