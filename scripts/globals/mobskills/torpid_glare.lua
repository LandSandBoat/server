---------------------------------------------
-- Torpid Glare
-- Description: Sleeps opponents with a gaze attack.
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Single gaze
-- Notes: Nightmare Cockatrice extends this to a fan-shaped AOE.
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
