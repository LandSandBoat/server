---------------------------------------------
-- Level 5 Petrify
--
-- Description: AOE Petrify and on multiples of 5.
-- Type: Physical
-- Utsusemi/Blink absorb: Ignore
-- Range: 15' radial
-- Notes:
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
    local typeEffect = tpz.effect.PETRIFICATION
    if (target:getMainLvl()%5 == 0) then


        local power = math.random(2, 30)

        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, power))

    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return typeEffect
end
