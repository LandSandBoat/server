---------------------------------------------
-- Smoke Bomb
-- Range: 10' cone
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BLINDNESS

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 20, 0, 120))

    return typeEffect
end
