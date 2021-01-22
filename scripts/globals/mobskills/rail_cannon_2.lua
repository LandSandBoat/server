-----------------------------------
-- Rail Cannon 2 gears
-- 2 Gears: Rail Cannon is directional (fan-shaped) AoE and ignores Utsusemi
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local typeEffect = tpz.effect.BIND
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.LIGHT, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, MOBSKILL_MAGICAL, MOBPARAM_LIGHT, MOBPARAM_IGNORE_SHADOWS)
    target:delHP(dmg)
    return dmg
end

return mobskill_object
