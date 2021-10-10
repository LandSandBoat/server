-----------------------------------
-- Bai Wing
--
-- Description: A dust storm deals Earth damage to enemies within a very wide area of effect. Additional effect: Slow
-- Type: Magical
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: 30' radial.
-- Notes: Used only by Ouryu and Cuelebre while flying.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.EARTH, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, MOBPARAM_WIPE_SHADOWS)

    MobStatusEffectMove(mob, target, xi.effect.SLOW, 3000, 0, 120)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskill_object
