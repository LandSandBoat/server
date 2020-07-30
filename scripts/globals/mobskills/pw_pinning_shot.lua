---------------------------------------------
-- Pinning Shot
--
-- Description: Delivers a threefold ranged attack to targets in an area of effect. Additional effect: Bind
-- Type: Physical
-- Utsusemi/Blink absorb: 2-3 shadows
-- Range: Unknown
-- Notes: Used only by Medusa.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobSkin = mob:getModelId()

    if (mobSkin == 1865) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.PIERCING, info.hitslanded)
    local typeEffect = tpz.effect.BIND

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 30)
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.PIERCING)

    return dmg
end
