---------------------------------------------
-- 10000 Needles
--
-- Description: Shoots multiple needles at enemies within range.
-- Type: Magical (Light)
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local needles = 10000 / skill:getTotalTargets()

    local dmg = MobFinalAdjustments(needles, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.LIGHT, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.LIGHT)

    return dmg
end
