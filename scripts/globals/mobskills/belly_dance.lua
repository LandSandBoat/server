---------------------------------------------
-- Belly Dance
--
-- Description: Charms all targets in an area of effect, that are facing the Lamia.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 15' radial
-- Notes: Used only by Lamia NM's, particularly in Besieged.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    --[[
    power = 1
    tic = 0
    duration = 60

    isEnfeeble = true
    typeEffect = tpz.effect.NAME
    statmod = tpz.mod.INT

    resist = applyPlayerResistance(mob, typeEffect, target, isEnfeeble, typeEffect, statmod)
    if (resist > 0.2) then
        if (target:getStatusEffect(typeEffect) == nil) then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
            target:addStatusEffect(typeEffect, power, tic, duration)
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end
    return typeEffect
    ]]
end
