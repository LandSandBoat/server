---------------------------------------------
-- Aeolian Void
--
-- Description: Fan AoE damage plus Silence and Blind
-- Type: Earth Damage/Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffectOne = tpz.effect.SILENCE
    local typeEffectTwo = tpz.effect.BLINDNESS

    MobStatusEffectMove(mob, target, typeEffectOne, 1, 0, 60)
    MobStatusEffectMove(mob, target, typeEffectTwo, 15, 0, 60)

    local dmgmod = MobBreathMove(mob, target, 0.25, 2.5, tpz.magic.ele.EARTH, 300)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.EARTH)
    return dmg
end
