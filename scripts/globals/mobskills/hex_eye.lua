---------------------------------------------
-- Hex Eye
--
-- Description: Paralyzes with a gaze.
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Line of sight
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
    local message = tpz.msg.basic.SKILL_MISS
    local typeEffect = tpz.effect.PARALYSIS

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 25, 0, 120))

    return typeEffect

end
