---------------------------------------------
-- Miasmic Breath
-- Description: A toxic odor is exhaled on any players in a fan-shaped area of effect.
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: 15' Conal
-- Notes: Only used by Cirrate Christelle
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/mobskills")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.POISON
    local power = mob:getLocalVar("miasmicbreathpower")

    MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = MobBreathMove(mob, target, 0.1, 1.25, xi.magic.ele.WATER, 200)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)

    return dmg
end

return mobskill_object
