---------------------------------------------
--  Sharp Sting
--
--  Description: Deals high damage to target in a ranged attack.
--  Type: Ranged
--  Utsusemi/Blink absorb: 1 shadow
--  Range: 10' single
--  Notes: Appears to be very inaccurate.
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 0.7
    local dmgmod = 2.5
    local info = MobRangedMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.PIERCING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.PIERCING)
    return dmg
end
