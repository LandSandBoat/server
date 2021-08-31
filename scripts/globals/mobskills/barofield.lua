-----------------------------------
--  Barofield
--
--  Description: Deals Wind damage to enemies within a fan-shaped area. Additional effect: Weight
--  Type: Magical
--  Ignores Shadows
--  Range: 15' Cone
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
    local dmgmod = 2.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, xi.magic.ele.WIND, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, MOBPARAM_IGNORE_SHADOWS)

    MobStatusEffectMove(mob, target, xi.effect.WEIGHT, 25, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end

return mobskill_object
