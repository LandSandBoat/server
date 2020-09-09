---------------------------------------------
--  Syphon Discharge
--
--  Family: Xzomit
--  Type: Breath
--  Can be dispelled: N/A
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes: Water Damage Knockback.
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = MobBreathMove(mob, target, 0.1, 1.25, tpz.magic.ele.WATER, 200)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)
    return dmg

end
