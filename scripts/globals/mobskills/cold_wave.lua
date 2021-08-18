-----------------------------------
--  Cold Wave
--
--  Description: Deals ice damage that lowers Agility and gradually reduces HP of enemies within range.
--  Type: Magical (Ice)
--
--
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
    local typeEffect = xi.effect.FROST

    local power = (mob:getMainLvl()/5 *.6 + 6)

    MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2.8, xi.magic.ele.ICE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end

return mobskill_object
