---------------------------------------------------
-- Divesting Stampede
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)

    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.MAGIC_DEF_DOWN, 30, 0, 60)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.DEFENSE_DOWN, 30, 0, 60)

    return dmg
end
