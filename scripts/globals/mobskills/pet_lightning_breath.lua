-----------------------------------
--  Lightning Breath
--
--  Description: Deals Lightning breath damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical (Lightning)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 0.25, xi.magic.ele.LIGHTNING, 125)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHTNING)
    return dmg
end

return mobskillObject
