---------------------------------------------------
-- Bonebreaking Barrage
-- Deals damage to a single target. Additional effect: Gravity, Max HP Down (-50%)
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
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,tpz.attackType.PHYSICAL,tpz.damageType.BLUNT,info.hitslanded)

    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.MAX_HP_DOWN, 0, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.WEIGHT, 50, 0, 30)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    return dmg
end
