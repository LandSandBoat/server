-----------------------------------
-- Calcifying Deluge
--
-- Description: Delivers a threefold ranged attack to targets in an area of effect. Additional effect: Petrification
-- Type: Physical
-- Utsusemi/Blink absorb: 2-3 shadows
-- Range: Unknown
-- Notes: Used only by Medusa.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    local typeEffect = xi.effect.PETRIFICATION
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 120)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
