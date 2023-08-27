-----------------------------------
--  Zephyr Arrow
--
--  Description: Deals a ranged attack to target. Additional effect: Knockback &amp Bind
--  Type: Ranged
--  Utsusemi/Blink absorb: Ignores Utsusemi
--  Range: Unknown
--  Notes:
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    local numhits = 1
    local accmod = 4
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 120)

    return dmg
end

return mobskillObject
