---------------------------------------------
-- Slumber Powder
-- 10' Conal sleep
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_I

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, 30))

    return typeEffect
end
