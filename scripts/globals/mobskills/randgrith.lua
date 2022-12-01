-----------------------------------
--  Randgrith
--
--  Description: Lowers target's evasion. Gullintani/Mjollnir: Temporarily improves accuracy.
--  Type: Physical
--  Range: Melee
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
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = 60
    local typeEffect = xi.effect.EVASION_DOWN
    local power = 32

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
