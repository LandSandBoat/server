-----------------------------------
--  Tidal Dive
--
--  Description: Dives at nearby targets. Additional effect: Weight and/or Bind (Status Effect)
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Unknown radial
--  Notes: Only used over deep water.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BIND

    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = .8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 30)

    typeEffect = xi.effect.WEIGHT
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 50, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    return dmg
end

return mobskillObject
