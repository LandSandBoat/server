---------------------------------------------
-- Saucepan
-- Force feeds an unsavory dish.
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
    local accmod = 1
    local dmgmod = 0.8
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    if (target:hasStatusEffect(tpz.effect.FOOD)) then
        target:delStatusEffectSilent(tpz.effect.FOOD)
    elseif (target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        target:delStatusEffectSilent(tpz.effect.FIELD_SUPPORT_FOOD)
    end
    target:addStatusEffectEx(tpz.effect.FIELD_SUPPORT_FOOD, tpz.effect.FOOD, 255, 0, 1800)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    return dmg
end
