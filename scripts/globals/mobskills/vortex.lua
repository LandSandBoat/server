---------------------------------------------------
-- Vortex
-- Creates a vortex that damages targets in an area of effect. Additional effect: Terror
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_3_SHADOW)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.TERROR, 1, 0, 9)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.BIND, 1, 0, 30)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    mob:resetEnmity(target)
    return dmg
end
