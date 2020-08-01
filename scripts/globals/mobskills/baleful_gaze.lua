---------------------------------------------
-- Baleful Gaze
-- Description: Petrifies opponents with a gaze attack.
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
    local typeEffect = tpz.effect.PETRIFICATION
    local duration = 45

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end
