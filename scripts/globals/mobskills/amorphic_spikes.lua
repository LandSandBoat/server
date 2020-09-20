---------------------------------------------
--  Amorphic Spikes
--
--  Description: Delivers a fivefold attack. Damage varies with TP.
--  Type: Physical
--  Utsusemi/Blink absorb: 5 shadows
--  Range: Unknown
--  Notes:
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 1.2, 1.5)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    return dmg
end
