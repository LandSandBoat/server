---------------------------------------------
-- Noisome Powder
-- Reduces attack of targets in area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if VanadielHour() >= 6 and VanadielHour() <= 18 then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ATTACK_DOWN
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 40, 0, 120))

    return typeEffect
end
