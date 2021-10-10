-----------------------------------
-- Dual Strike
--
-- Family: Xzomit
-- Type: Physical
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: 2 shadows
-- Range: Melee
-- Notes: Double attacks a single target. Additional effect: Stun
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    local typeEffect = xi.effect.STUN

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    return dmg
end

return mobskill_object
