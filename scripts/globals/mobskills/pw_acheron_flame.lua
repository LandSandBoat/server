---------------------------------------------
-- Acheron Flame
--
-- Description: Deals severe Fire damage to enemies within an area of effect. Additional effect: Burn
-- Type:  Magical
--
--
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: 20' radial
-- Notes: Only used when a cerberus's health is 25% or lower (may not be the case for Orthrus). The burn effect takes off upwards of 20 HP per tick.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobSkin = mob:getModelId()

    if (mobSkin == 1793) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BURN
    local statmod = tpz.mod.INT
    local element = mob:getStatusEffectElement(typeEffect)
    local resist = applyPlayerResistance(mob, typeEffect, target, mob:getStat(statmod)-target:getStat(statmod), 0, element)

    local power = ((resist * 10) - 5) * math.random(1, 2) + 19 -- makes dot damage between 20 - 28, based off resistance and random variable.
    local dmgmod = 3
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*6, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)

    MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)

    return dmg
end
