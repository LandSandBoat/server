---------------------------------------------
-- Heavy Stomp
--
-- Description: Deals heavy damage to targets within an area of effect. Additional effect: Paralysis
-- Type: Physical
-- Utsusemi/Blink absorb: 2-3 shadows
-- Range: Unknown radial
-- Notes: Paralysis effect has a very long duration.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    local mobSkin = mob:getModelId()

    if (mobSkin == 421) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = .7
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    local typeEffect = tpz.effect.PARALYSIS

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 15, 0, 360)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    return dmg
end
