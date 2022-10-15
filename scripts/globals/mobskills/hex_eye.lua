-----------------------------------
-- Hex Eye
--
-- Description: Paralyzes with a gaze.
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Line of sight
-- Notes:
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 25, 0, 120))

    return typeEffect
end

return mobskillObject
