---------------------------------------------------
-- Sand Breath
-- Deals Earth damage to enemies within a fan-shaped area. Additional effect: Blind
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BLINDNESS

    MobStatusEffectMove(mob, target, typeEffect, 20, 0, 180)

    local dmgmod = MobBreathMove(mob, target, 0.2, 0.75, tpz.magic.ele.EARTH, 800)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.EARTH)
    return dmg
end
