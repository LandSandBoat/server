---------------------------------------------
-- Difusion Ray
-- Description: Deals damage to enemies within a fan-shaped area originating from the caster.
-- Type: Magical Light (Element)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobBreathMove(mob, target, 0.2, 0.65, tpz.magic.ele.LIGHT, 500)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.damageType.BREATH, tpz.attackType.LIGHT, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.LIGHT)

    return dmg
end
