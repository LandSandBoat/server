-----------------------------------
--  Numbing Breath
--
--  Description: Deals ice damage to enemies within a fan-shaped area originating from the caster. Additional effect: Paralyze.
--  Type: Magical Ice (Element)
--
--
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, math.random(120, 180))

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1, xi.magic.ele.ICE, 500)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)
    return dmg
end

return mobskillObject
