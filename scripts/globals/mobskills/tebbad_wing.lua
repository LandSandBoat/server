-----------------------------------
--  Tebbad Wing
--
--  Description: A hot wind deals Fire damage to enemies within a very wide area of effect. Additional effect: Plague
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 30' radial.
--  Notes: Used only by Tiamat, Smok and Ildebrann
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES)) then
        return 1
    elseif (mob:getAnimationSub() == 1) then
        return 1
    elseif (target:isBehind(mob, 48) == true) then
        return 1
    end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PLAGUE

    MobStatusEffectMove(mob, target, typeEffect, 10, 0, 120)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*5, xi.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskill_object
