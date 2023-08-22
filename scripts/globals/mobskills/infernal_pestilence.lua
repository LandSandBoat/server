-----------------------------------
--  Infernal Pestilence
--
--  Description: Releases a horrible disease on targets in front.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Front arc
--  Notes: Only used by Chahnameed's Stomach.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 780)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.WATER, 200)
    local dmg    = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end

return mobskillObject
