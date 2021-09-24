-----------------------------------
--  Wing Thrust
--  Family: Aern
--  Type: Physical
--  Can be dispelled: N/A
--  Utsusemi/Blink absorb: 4 Shadows
--  Range: Single Target 7.0'
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
    local typeEffect = xi.effect.SLOW

    local numhits = 4
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1250, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    return dmg
end

return mobskill_object
