-----------------------------------
-- Earthbreaker
--
-- Description: Deals Earth damage to enemies within area of effect. Additional effect: Stun
-- Type: Magical
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: 15' radial
-- Notes:
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.STUN
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 8)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*6, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskill_object
