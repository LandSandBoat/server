---------------------------------------------
-- Cold Stare
-- Silences enemies in a line area of effect.
-- Notes: Only applies when face-to-face with the dhalmel.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SILENCE
    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, 60))
    return typeEffect
end
