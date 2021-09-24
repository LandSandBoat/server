-----------------------------------
--  Cyclonic Torrent
--
--  Description: Area of Effect damage plus Mute to those in range.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Wipes Shadows
--  Range: 20' radial
--  Notes: Only used by Urd, Verthandi, and Carabosse.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    local typeEffect = xi.effect.MUTE

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 60)

    return dmg
end

return mobskill_object
