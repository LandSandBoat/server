-----------------------------------
--  Sprout Smack
--
--  Description: Additional effect: Slow.  Duration of effect varies with TP.
--  Type: Physical (Blunt)
--
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.SLOW

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1000, 0, 120)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 100, 0, 120)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskill_object
