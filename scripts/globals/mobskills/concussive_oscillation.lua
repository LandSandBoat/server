-----------------------------------
-- Concussive Oscillation
-- Smacks around all nearby targets. Additional effect: Knockback + Weight
-- Utsusemi/Blink absorb: 2-3 shadows
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
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, MOBPARAM_3_SHADOW)
    local typeEffect = xi.effect.WEIGHT

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 50, 0, 300)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskill_object
