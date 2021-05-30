-----------------------------------
--  Miasma
--
--  Description: Releases a toxic cloud on nearby targets. Additional effects: Slow + Poison + Plague
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows?
--  Range: Less than or equal to 10.0
--  Notes: Only used by Gulool Ja Ja.
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
    -- local duration = 180
    MobStatusEffectMove(mob, target, xi.effect.POISON, mob:getMainLvl() / 3, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 3, 120)
    MobStatusEffectMove(mob, target, xi.effect.POISON, mob:getMainLvl()/3, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.SLOW, 128, 3, 120)
    MobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 60)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.EARTH, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskill_object
