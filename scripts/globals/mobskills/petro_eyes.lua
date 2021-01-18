---------------------------------------------
-- Petro Eyes
-- Description: Petrifies opponents with a gaze attack.
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Single gaze
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.PETRIFICATION

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, 60))
    return typeEffect
end

return mobskill_object
