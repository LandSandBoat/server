-----------------------------------
--  Blade Metsu
--
--  Description: Additional effect: Paralysis Kikoku/Yoshimitsu: Temporarily enhances Subtle Blow xi.effect.
--  Type: Physical
--  Range: Melee
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 3, 3, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = 60
    local typeEffect = xi.effect.PARALYSIS
    local power = 10

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg

end

return mobskill_object
