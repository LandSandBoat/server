-----------------------------------
--  Poison Breath
--  Description: Deals water damage to enemies within a fan-shaped area originating from the caster. Additional effect: Poison.
--  Type: Magical Water (Element)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.POISON
    local power = math.ceil(mob:getMainLvl() / 5)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1.25, xi.magic.ele.WATER, 200)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end

return mobskillObject
